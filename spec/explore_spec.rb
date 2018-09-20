require File.expand_path('../../lib/explore', __FILE__)
require File.expand_path('../../lib/mars_plateau', __FILE__)

describe Explore, "behaviour" do
    let (:file_line_array) { ["5 5\n", "1 2 N\n", "LMLMLMLMM\n", "3 3 E\n", "MMRMMRMRRM\n"] }

    before :each do
        @explore = Explore.new file_line_array
        @mars_plateau = MarsPlateau.new file_line_array[0]
        @result = @explore.explore_plateau(file_line_array[1..-1]) 
    end

    it "initializes" do
        expect(@explore).to_not eq nil
        expect(@mars_plateau).to_not eq nil
    end

    it "rovers explores the plateua and returns the final rovers position" do
        expect(@result).to eq [{:orientation=>"N", :x=>"1", :y=>"3"}, {:orientation=>"E", :x=>"5", :y=>"1"}]
    end
end
