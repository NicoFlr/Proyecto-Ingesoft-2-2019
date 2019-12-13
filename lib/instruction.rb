require_relative './vehicle'
require_relative './errores/invalid_instruction'
require_relative './errores/out_of_field'

class Instruction

  attr_accessor :vehicle

  def initialize
    @moves = {:left => "I", :right => "D", :front => "A"}
    @vehicle = Vehicle.new
  end

  def execute_instruction instruction
    if (instruction_exist instruction)
      is_out_of_the_field
      begin
        case instruction
        when @moves[:left]
          @vehicle.turn_left
        when @moves[:right]
          @vehicle.turn_right
        when @moves[:front]
          @vehicle.advance
        end
        check_if_the_vehicle_is_out_of_the_field
      rescue InvalidXPosition
        @vehicle.set_x_position 0
      rescue InvalidYPosition
        @vehicle.set_y_position 0
      end
    else
      raise InvalidInstruction.new
    end
  end

  def set_position_of_vehicle(x, y)
    @vehicle.set_x_position x
    @vehicle.set_y_position y
  end

  def get_position_of_vehicle_in_X
    @vehicle.get_x_position
  end

  def get_position_of_vehicle_in_Y
    @vehicle.get_y_position
  end

  def set_vehicle_orientation(orientation)
    @vehicle.guide orientation
  end

  def get_vehicle_orientation
    @vehicle.get_orientation
  end

  def set_field field
    @field = field
  end

  def get_field
    @field
  end

  def execute_instruction_series
    @instruction_series.each_char { |instruction|
      execute_instruction instruction
    }
  end

  def set_up_instruction_series(instruction_series, vehicle_position_in_x, vehicle_position_in_y, orientation)
    @instruction_series = instruction_series
    set_position_of_vehicle vehicle_position_in_x, vehicle_position_in_y
    set_vehicle_orientation orientation
  end

  private
  def instruction_exist instruction
    "IDA".include? instruction
  end

  def check_if_the_vehicle_is_out_of_the_field
    if @vehicle.get_x_position > @field.get_columns
      @vehicle.set_x_position @field.get_columns
    end
    if @vehicle.get_y_position > @field.get_rows
      @vehicle.set_y_position @field.get_rows
    end
  end

  def is_out_of_the_field
    if @vehicle.get_x_position > @field.get_columns or @vehicle.get_y_position > @field.get_rows
      raise OutOfFieldError.new
    end
  end
end