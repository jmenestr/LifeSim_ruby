require_relative "vector"

class Wall

  def initialize(char="#")
    @char = char
  end

  attr_accessor :char

end

class Space
  def initialize(char=" ")
    @char = char
  end

  attr_reader :char
end

class Life
  def initialize(char="x",pos=GridVector.new(-1,-1))
    @char = char
    @position = pos
    @directions = {
        "n"=> GridVector.new(0,1),
        "ne" => GridVector.new(1,1),
        "e" => GridVector.new(1,0),
        "se" =>  GridVector.new(1,-1),
        "s" => GridVector.new(0,-1),
        "sw" => GridVector.new(-1,-1),
        "w" => GridVector.new(-1,0),
        "nw" => GridVector.new(-1,1)
    }
    @energy = 0
    @dead = false

  end


  attr_reader :char
  attr_accessor :energy,:position

  def get_direction
    dir_keys = @directions.keys
    dir_keys.sample
  end

  def look_around(world_grid,direction)
    target_pos = @position.plus(direction)
    world_grid.get(target_pos)
  end

  def find_squares_of(world_grid,element)
    direction_values = @directions.values
    target_direction_vectors = direction_values.select do
      |direction|
      target = look_around(world_grid,direction)
      target.is_a?(element)
    end
    target_direction_vectors
  end

  def die
    event = {"action" => "die"}
    return event,@position
  end


  def kill
    self.dead = true
  end

  def is_dead?
    @dead
  end

end

class Critter < Life
  def initialize(char)
    super
    @energy = 10
  end

  def act(world_grid)
    if @energy <= 0
      die
    else
      move(world_grid)
    end
  end

  def move(world_grid)
    event = {"action" => "move"}
    @energy -= 0.2
    free_spaces = find_squares_of(world_grid,Space)
    if free_spaces.length > 0
      dest = free_spaces.sample
      return event,@position.plus(dest)
    else
      return event,@position
    end
  end

end
