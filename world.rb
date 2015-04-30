require_relative "grid"
require_relative "creatures"

class World
  def initialize(plan,legend)
    @grid = Grid.new(plan.length,plan[0].length)
    @legend = {" " => Space}.merge(legend)
    @critters = []
    @plants = []
    setUpWorld(plan)
  end

  attr_reader :critters

  def createElement(char)
      @legend[char].new(char)
  end

  def setUpWorld(plan)
    plan.each_with_index do |line,y |
      line = line.split("")
      line.each_with_index do |char,x|
        element = createElement(char)
        if element.is_a?(Critter)
          element.position = GridVector.new(x,y)
          @critters.push(element)
        elsif element.is_a?(Plant)
          element.position = GridVector.new(x,y)
          @plants.push(element)
        end
        @grid.set(GridVector.new(x,y),element)
      end
    end
  end

  def charFromElement(element)
      element.char
  end

  def turn
    critters_after_turn = []
    @critters.each do
      |critter|
      (event,dest) = critter.act(@grid)
      if event["action"] == "move"
        @grid.set(critter.position,Space.new)
        @grid.set(dest,critter)
        critter.position = dest
        critters_after_turn.push(critter)
      elsif event["action"] == "eat"
        target = @grid.get(dest)
        target_plant_energy = target.energy
        critter.energy += target_plant_energy
        target.kill
        @grid.set(critter.position,Space.new)
        critter.position = dest
        @grid.set(dest,critter)
        critters_after_turn << critter
      elsif event["action"] == "reproduce"
        baby_crit = Critter.new(critter.char)
        baby_crit.position = dest
        @grid.set(dest,baby_crit)
        critters_after_turn.push(critter)
        critters_after_turn.push(baby_crit)
      elsif event["action"] == "die"
        @grid.set(critter.position,Space.new)
      end
    end
    @critters = critters_after_turn

    plants_after_turn = []
    @plants.each do
      |plant|
      if plant.is_dead?
        next
      end
      (event,dest) = plant.act(@grid)
      if event["action"] == "grow"
        plants_after_turn.push(plant)
      elsif event["action"] == "reproduce"
        new_plant = Plant.new(plant.char,dest)
        @grid.set(dest,new_plant)
        plants_after_turn.push(plant)
        plants_after_turn.push(new_plant)
      end
    end
    @plants = plants_after_turn
  end

  def to_s
    world_string = ""
    (0...@grid.height).each do
      |y|
      (0...@grid.width).each do
        |x|
        element = @grid.get(GridVector.new(x,y))
        char = charFromElement(element)
        world_string += char
      end
      world_string += "\n"
    end
    world_string
  end

end