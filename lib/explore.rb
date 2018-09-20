require File.expand_path('../mars_plateau', __FILE__)
require File.expand_path('../rover', __FILE__)

class Explore
  attr_accessor :mars_plateau

  def initialize(line_array)
    @mars_plateau = MarsPlateau.new(line_array[0])
  end

  def explore_plateau(nasa_cmd)
    final_rover_positions = []
    nasa_cmd.each_slice(2) do |rover_input|
      final_rover_positions << create_rover(rover_input, @mars_plateau)
    end
    final_rover_positions
  end

  def create_rover(rover_input, mars_plateau)
      rover = Rover.new(rover_input[0], mars_plateau)
      nasa_command = rover_input[1].gsub("\n", '')

      navigate_rover(rover, nasa_command)

      final_rover_position = rover.position

      rover.error_messages&.each do |msg|
        puts "#{msg}"
      end
      rover.error_messages.clear
      final_rover_position
  end

  def navigate_rover(rover, cmd)
    rover.navigate_rover_on_plateau(rover.position, cmd) if rover.allow_move
  end
end
