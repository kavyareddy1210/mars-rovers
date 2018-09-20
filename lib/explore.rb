require File.expand_path('../mars_plateau', __FILE__)
require File.expand_path('../rover', __FILE__)

class Explore
  def initialize(line_array)
    mars_plateau = MarsPlateau.new(line_array[0])

    position_rover(line_array[1..-1], mars_plateau) if mars_plateau.ready_to_explore
  end

  def position_rover(nasa_cmd, mars_plateau)
    nasa_cmd.each_slice(2) do |rover_input|
      rover = Rover.new(rover_input[0], mars_plateau)

      nasa_command = rover_input[1].gsub("\n", '')

      navigate_rover(rover, nasa_command)

      format_output_to_display(rover.position)

      rover.error_messages&.each do |msg|
        puts "#{msg}"
      end
      rover.error_messages.clear
    end
  end

  def navigate_rover(rover, cmd)
    rover.navigate_rover_on_plateau(rover.position, cmd) if rover.allow_move
  end

  def format_output_to_display(position)
    position.map { |k, v| print v.to_s + " " }
    puts
  end
end