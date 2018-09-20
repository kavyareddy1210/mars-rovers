require File.expand_path('../../lib/mars_plateau', __FILE__)

describe MarsPlateau, "behaviour" do
    let (:upper_coordinates) { "5 5\n" }

    before :each do
        @mars_plateau = MarsPlateau.new upper_coordinates
    end

    it "initializes" do
        expect(@mars_plateau).to_not eq nil
    end

    it "creates mars plateau bounded by upper coordinates" do
        expect(@mars_plateau.coordinates[:upper]).to eq ["5", "5"]
        expect(@mars_plateau.coordinates[:lower]).to eq ["0", "0"]
    end

    it "makes plateau ready to explore for rovers" do
        expect(@mars_plateau.ready_to_explore).to eq true
    end

    context "on every rovers move" do
        let (:rover_position_1) { {:x=>"1", :y=>"2"} }
        let (:rover_position_2) { {:x=>"6", :y=>"2"} }

        it "validates rovers position on the plateau to enable rover_position_1 move" do
            expect(@mars_plateau.validate_rover_position(rover_position_1)).to eq [true, []]
            expect(@mars_plateau.allow_move).to eq true
        end

        it "validates rovers position on the plateau to enable rover_position_2 move" do
            expect(@mars_plateau.validate_rover_position(rover_position_2)).to eq [false, ["Invalid command. Plateau boundary reached or invalid rover position . Unable to move Rover."]]
            expect(@mars_plateau.allow_move).to eq false
        end
    end
end