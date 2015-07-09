require 'aasm'

module Robot
  class Toy
    include AASM

    attr_accessor :x, :y, :direction

    $DIRECTIONS = [:north, :east, :south, :west]

    def initialize(direction = :north)
      @x = nil
      @y = nil
      @direction = direction
    end

    def add_coordinates(x,y)
      self.x = x
      self.y = y
    end

    def view
      {x: self.x, y: self.y, direction: self.direction}
    end

    def turn_left
      @direction = order_directions[-1]
    end

    def turn_right
      @direction = order_directions[1]
    end

    def order_directions
      $DIRECTIONS.rotate($DIRECTIONS.index(direction))
    end

    def coordinates
      [x, y]
    end

    def remove_coordinates
      @x = nil
      @y = nil
    end
  end
end