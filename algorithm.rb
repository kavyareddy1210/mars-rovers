puts "Welcome to Mars. Thank for exploring our plateau. Outputs of our ROBOT navigations is as follows."

def change_cardinal_direction(orientation, command)
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
        puts "wrong command string"
    end
    orientation_next
end

def change_grid_position(rover_position)
    case rover_position[:orientation]
    when 'E'
        rover_position[:x] = rover_position[:x].to_i + 1
    when 'W'
        rover_position[:x] = rover_position[:x].to_i - 1
    when 'N'
        rover_position[:y] = rover_position[:y].to_i + 1
    when 'S'
        rover_position[:y] = rover_position[:y].to_i - 1
    else
        puts "wrong command string"
    end
    rover_position
end

def navigate_rover(rover_cmd, upper_coordinates)
    rover_position = rover_cmd[0].gsub("\n",'').split(" ")

    return "Cannot move Robot. command on position Limit exceeded "  if !rover_position[0..1].zip(upper_coordinates).all? { |a, b| a < b}

    nasa_command = rover_cmd[1].gsub("\n", '')
    position = [:x, :y, :orientation]
    rover_position = Hash[position.zip(rover_position)]

    nasa_command.each_char do |cmd|
        case cmd
        when 'L', 'R'
            rover_position[:orientation] = change_cardinal_direction(rover_position[:orientation], cmd)
        when 'M'
            rover_position = change_grid_position(rover_position)
        else
        end
    end
    rover_position
end

begin
    line_array = File.open(ARGV[0],"r").readlines


    test =  File.read(ARGV[0]).chars.reject!{|char| char == " " || char == "\n"}
    puts "#{test.shift(2)}"
    puts "Error in command from input file" if (File.zero?(ARGV[0]) || line_array.size.even?)
    line_array[1..-1].each_slice(2) do |rover_cmd|
        navigate_rover(rover_cmd, line_array[0].split(" ")).map { |k, v| print v.to_s + " " }
        puts
    end
rescue
    puts "File cannot be opened. Please check again and input correct file" # provide way for user to input file again user gets.chomp method to enter file name and repeat tghe process
end


