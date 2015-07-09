class Robot::Controller
  attr_accessor :table, :toy

  def initialize(toy, table)
    @table = table
    @toy = toy
  end

  def exec(command, arguments = [])
    response = ""
    if @table.item_placed?(@toy)
      case command
      when "PLACE"
        place(*arguments) if arguments.count == 3
      when "MOVE"
        move
      when "LEFT"
        left
      when "RIGHT"
        right
      when "REPORT"
        response = report
      else

      end
    else
      place(*arguments) if command == "PLACE" && arguments.count == 3
    end

    return response
  end

  private

  def report
    table.view
  end

  def place(x, y, direction)
    begin
      table.place(toy, x.to_i, y.to_i)
      toy.direction = direction_format(direction)
    rescue Robot::BoundError
      table.take(toy)
    end
    return
  end

  def left
    toy.turn_left
  end

  def right
    toy.turn_right
  end

  def move
    case toy.direction
        when :north
          toy.y +=1 if @table.valid_x_position?(toy.y + 1)
        when :east
          toy.x+=1 if @table.valid_y_position?(toy.x + 1)
        when :west
          toy.x-=1 if @table.valid_x_position?(toy.x - 1)
        when :south
          toy.y-=1 if @table.valid_y_position?(toy.y - 1)
    else
    end
    return
  end

  def direction_format(direction)
    direction.strip.downcase.to_sym
  end
end