require './lib/explore.rb'

begin
  line_array = File.open(ARGV[0],"r").readlines
  line_array.delete("\n")

  if (File.zero?(ARGV[0]) || line_array.size.even?)
    puts "Error in input file. Please try again"
    exit(false)
  elsif line_array.size == 1
    puts "No commands specifide by NASA"
    exit(false)
  end

  Explore.new(line_array)
rescue
  puts "File cannot be opened. Please check again and input correct file"
end