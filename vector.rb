class GridVector

  def initialize(x,y)
    @x = x
    @y = y
  end

  attr_accessor :x,:y

  def plus(other_vector)
    GridVector.new(@x + other_vector.x,@y + other_vector.y)
  end


end


