require_relative './vehicle'
require_relative './errores/invalid_instruction'

class Instruction

  attr_accessor :vehicle

  def initialize
    @moves = {:left => "I", :right => "D", :front => "A"}
    @vehicle = Vehicle.new
  end

  def execute_instruction instruction
    if (instruction_exist instruction)
      begin
        case instruction
        when @moves[:left]
          @vehicle.turn_left
          @vehicle.advance
        when @moves[:right]
          @vehicle.turn_right
          @vehicle.advance
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

  def set_position_of_vehicle x, y
    @vehicle.set_x_position x
    @vehicle.set_y_position y
  end

  def set_vehicle_orientation orientation
    @vehicle.guide orientation
  end

  def set_field field
    @field = field
  end

  def get_field
    @field
  end

  private
  def instruction_exist instruction
    "IDA".include? instruction
  end

  def check_if_the_vehicle_is_out_of_the_field
    puts @vehicle.get_x_position
    puts @field.get_columns
    if @vehicle.get_x_position > @field.get_columns
      @vehicle.set_x_position @field.get_columns
    end
    if @vehicle.get_y_position > @field.get_rows
      @vehicle.set_y_position @field.get_rows
    end
  end
end