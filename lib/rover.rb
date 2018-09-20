class Rover
    attr_accessor :position, :allow_move, :error_messages, :mars_plateau

    def initialize(rover_input, mars_plateau)
        position_keys = [:x, :y, :orientation]
        position_values = rover_input.gsub("\n",'').split(" ")

        @mars_plateau = mars_plateau
        @error_messages ||= []
        @position = Hash[position_keys.zip(position_values)]

        @allow_move, @error_messages  =  @mars_plateau.validate_rover_position(@position.slice(:x, :y))
    end

    def navigate_rover_on_plateau(rover_position, nasa_command)
        nasa_command.each_char do |cmd|
            case cmd
            when 'L', 'R'
                @position = change_rover_orientation(rover_position, cmd)
            when 'M'
                @allow_move, @error_messages = @mars_plateau.validate_rover_position(@position.slice(:x, :y))
                @position = change_rover_grid_position(rover_position) if @allow_move
            else
                @error_messages << "Invalid command string #{cmd}"
            end
        end
    end

    def change_rover_orientation(rover_position, command)
        case rover_position[:orientation]
        when 'E'
            rover_position[:orientation] = command == 'L' ? 'N' : 'S'
        when 'W'
            rover_position[:orientation] = command == 'L' ? 'S' : 'N'
        when 'N'
            rover_position[:orientation] = command == 'L' ? 'W' : 'E'
        when 'S'
            rover_position[:orientation] = command == 'L' ? 'E' : 'W'
        else
            @error_messages << "Invalid command string"
        end
        rover_position
    end

    def change_rover_grid_position(rover_position)
        case rover_position[:orientation]
        when 'E'
            rover_position[:x] = (rover_position[:x].to_i + 1).to_s
        when 'W'
            rover_position[:x] = (rover_position[:x].to_i - 1).to_s
        when 'N'
            rover_position[:y] = (rover_position[:y].to_i + 1).to_s
        when 'S'
            rover_position[:y] = (rover_position[:y].to_i - 1).to_s
        else
            @error_messages <<  "Invalid rover orientation string #{rover_position[:orientation]}"
        end
        rover_position
    end
end