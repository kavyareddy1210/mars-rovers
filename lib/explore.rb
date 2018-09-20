require File.expand_path('../mars_plateau', __FILE__)
require File.expand_path('../rover', __FILE__)

class Explore
  def initialize(line_array)
    mars_plateau = MarsPlateau.new(line_array[0])

    position_and_navigate_rover(line_array[1..-1], mars_plateau) if mars_plateau.ready_to_explore
  end

  def position_and_navigate_rover(nasa_cmd, mars_plateau)
    nasa_cmd.each_slice(2) do |rover_input|
      rover = Rover.new(rover_input, mars_plateau)
      rover.position.map { |k, v| print v.to_s + " " }
      puts

      rover.error_messages&.each do |msg|
        puts "#{msg}"
      end
      rover.error_messages.clear
    end
  end
end