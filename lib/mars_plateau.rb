class MarsPlateau
    attr_accessor :coordinates, :allow_move, :ready_to_explore, :error_messages
  
    def initialize(upper_coordinates)
      @coordinates = { :upper => upper_coordinates.gsub("\n",'').split(" "), :lower => ["0", "0"] }
      @ready_to_explore = true
      @error_messages ||= []
    end

    def validate_rover_position(rover_position_coordinates)
      if (rover_position_coordinates.values.zip(@coordinates[:upper]).all? { |a, b| a <= b } && rover_position_coordinates.values.zip(@coordinates[:lower]).all? { |a, b| a >= b })
          @allow_move = true
      else
          @allow_move = false
          @error_messages << "Invalid command. Plateau boundary reached or invalid rover position #{@rover_position_coordinates}. Unable to move Rover."
      end

      [@allow_move, @error_messages]
    end
  end