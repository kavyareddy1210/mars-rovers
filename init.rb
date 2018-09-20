require './lib/explore.rb'

def validate_input(file)
  line_array  = File.open(file,"r").readlines
  line_array.delete("\n")
  validated = false
  error_message = ""

  if File.zero?(file)
    error_message = "Input file empty. Plesae input correct command file and try again."
  elsif line_array.size == 1
    error_message = "No commands specifide by NASA"
  elsif line_array.size.even?
    error_message = "Error in input file. Please try again"
  else
    validated = true
  end
  [validated, error_message]
end

def format_output_to_display(final_rover_position)
  result = ""
  final_rover_position.values.each do |v|
    result = result.concat(v + " ")
  end
  result.strip
end

begin
  result = validate_input(ARGV[0])

  if !result[1].empty? 
    puts "#{result[1]}"
    exit(false)
  end

  line_array = File.open(ARGV[0],"r").readlines
  line_array.delete("\n")

  explore = Explore.new(line_array) if result[0]
  final_rover_positions = explore.explore_plateau(line_array[1..-1]) if explore.mars_plateau.ready_to_explore

  final_rover_positions.each do |pos|
    puts "#{format_output_to_display(pos)}"
  end
rescue
  puts "File cannot be opened. Please check again and input correct file"
end
