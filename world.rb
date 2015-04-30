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
    @critter.each do
      |critter|
      (event,dest) = critter.act(@grid)
      if event["action"] == "move"
        @grid.set(critter.position,Space.new)
        @grid.set(dest,critter)
        critter.position = dest
        critters_after_turn.push(critter)
      end
    end
    @critters = critters_after_turn
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