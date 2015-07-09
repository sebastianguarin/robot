module Robot
  class Table

    attr_accessor :width, :height, :items

    def initialize(options = {})
      @width = options[:width] || 5
      @height = options[:height] || 5
      @items = []
    end

    def place(item, x = 0, y = 0)
      if valid_coordinates?(x, y)
        items.push(item) unless item_placed?(item)
        item.add_coordinates(x,y)
      else
        raise Robot::BoundError
      end
    end

    def valid_coordinates?(x, y)
      valid_x_position?(x) && valid_y_position?(y) && coordinate_are_avaliable?(x, y)
    end

    def valid_x_position?(position)
      position >= 0 && position <= self.width
    end

    def valid_y_position?(position)
      position >= 0 && position <= self.height
    end

    def item_placed?(item)
      find_item(item) ? true : false
    end

    def find_item(item)
      item_index = items.index(item)
      item_index ? items[item_index] : nil
    end

    def view
      {items: items.collect{|item| item.view}}
    end

    def take(item)
      if @items.delete(item)
        item.remove_coordinates
      end
    end

    def items_coordinates
      items.collect{|item| item.coordinates}
    end

    def coordinate_are_avaliable?(x, y)
      !items_coordinates.include?([x, y])
    end
  end
end