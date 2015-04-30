class Grid

  def initialize(height,width)
    @space = Array.new(height*width) {|item| nil}
    @width = width
    @height = height
  end

  attr_reader :width,:height

  def isInside?(vector)
    vector.x >= 0 and vector.x < @width and vector.y >= 0 and vector.y < @height
  end

  def get(vector)
    @space[vector.x + @width*vector.y]
  end

  def set(vector,value)
    if isInside?(vector)
      @space[vector.x + @width*vector.y] = value
    end
  end
end