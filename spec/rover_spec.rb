require File.expand_path('../../lib/rover', __FILE__)
require File.expand_path('../../lib/mars_plateau', __FILE__)

describe Rover, "behaviour" do
    let (:rover_input) { "1 2 N\n" }

    before :each do
        @mars_plateau = MarsPlateau.new "5 5\n"
        @rover = Rover.new rover_input, @mars_plateau
    end

    it "initializes" do
        expect(@rover).to_not eq nil
    end

    it "Creates rovers position" do
        expect(@rover.position).to include({:x => "1", :y => "2", :orientation => "N"})
    end

    it "validates rovers initial position and enable it to move" do
        expect(@mars_plateau.validate_rover_position(@rover.position.slice(:x, :y))).to eq [true, []]
        expect(@mars_plateau.allow_move).to eq true
    end

    context "On receiving command L" do
        before :each do 
            @rover.change_rover_orientation(@rover.position, 'L')
        end

        it "rover turns Left" do
            expect(@rover.position).to include({:x=>"1", :y=>"2", :orientation=>"W"}) 
        end
    end

    context "On receiving command R" do
        before :each do 
            @rover.change_rover_orientation(@rover.position, 'R')
        end

        it "rover turns Right" do
            expect(@rover.position).to include({:x=>"1", :y=>"2", :orientation=>"E"}) 
        end
    end

    context "On receiving command M" do
        before :each do 
            @rover.change_rover_grid_position(@rover.position)
        end

        it "rover moves ahead left" do
            expect(@rover.position).to include({:x=>"1", :y=>"3", :orientation=>"N"}) 
        end
    end

    context "when navigating rover on the plateau" do
        let (:nasa_command) { "LMLMLMLMM" }

        before do
            @rover.navigate_rover_on_plateau(@rover.position, nasa_command)
        end

        it "moves rover to [1,3,N] position on plateau" do
            expect(@rover.position).to include({:x=>"1", :y=>"3", :orientation=>"N"})
        end
    end
end
