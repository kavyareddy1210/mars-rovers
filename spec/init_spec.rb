require 'spec_helper'
require File.expand_path('../../init.rb', __FILE__)

describe "Running app to explore" do
    let (:valid_input_file) { File.expand_path '././spec/sample_input.txt' }
    let (:error_input_file) { File.expand_path '././spec/error_input.txt' }
    let (:before_formatting) { {:x=>"1", :y=>"3", :orientation=>"N"} }
    
    before :each do
        @line_array = File.open(valid_input_file,"r").readlines
        @line_array.delete("\n")
        @after_formatting = format_output_to_display(before_formatting)
    end

    
    context "on passing correct file" do
        it "validates input to true" do
            expect(validate_input(valid_input_file)[0]).to eq true
            
        end 
    end

    context "on passing error file" do
        it "validates input to false" do
            expect(validate_input(error_input_file)[0]).to eq false
        end 
    end

    it "formats rover position into a neat string to display" do
        expect(@after_formatting).to eq "1 3 N"
    end
end
