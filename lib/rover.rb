class Rover
    attr_accessor :position, :allow_move, :error_messages, :mars_plateau

    def initialize(rover_input, mars_plateau)
        position_keys = [:x, :y, :orientation]
        position_values = rover_input[0].gsub("\n",'').split(" ")
        nasa_command = rover_input[1].gsub("\n", '')
        @mars_plateau = mars_plateau
        @error_messages ||= []

        @position = Hash[position_keys.zip(position_values)]
        @allow_move =  @mars_plateau.validate_rover_position(@position.slice(:x, :y))

        navigate_rover_on_plateau(@position, nasa_command) if @allow_move
    end

    def navigate_rover_on_plateau(rover_position, nasa_command)
        nasa_command.each_char do |cmd|
            case cmd
            when 'L', 'R'
                @position[:orientation] = change_rover_orientation(rover_position[:orientation], cmd)
            when 'M'
                @allow_move = @mars_plateau.validate_rover_position(@position.slice(:x, :y))
                @position = change_rover_grid_position(rover_position) if @allow_move
            else
                @error_messages << "Invalid command string #{cmd}"
            end
        end
    end

    def change_rover_orientation(orientation, command)
        case orientation
        when 'E'
            orientation_next = command == 'L' ? 'N' : 'S'
        when 'W'
            orientation_next = command == 'L' ? 'S' : 'N'
        when 'N'
            orientation_next = command == 'L' ? 'W' : 'E'
        when 'S'
            orientation_next = command == 'L' ? 'E' : 'W'
        else
            @error_messages << "Invalid command string"
        end
        orientation_next
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