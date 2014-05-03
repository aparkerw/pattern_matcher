require 'spec_helper'

module PatternMatcher
  describe Match do
  
    describe "::initialize" do
      it "should work given a valid hash" do
        a_match = Match.new(sample_match_hash)
        a_match.name.should == sample_match_hash[:name]
        a_match.regex_match.should == sample_match_hash[:regex_match]
      end

      it "should behave correctly given {}" do
        a_match = Match.new({})
      end

      it "should behave correctly given ''" do
        a_match = Match.new('')
      end

      it "should behave correctly given nil" do
        a_match = Match.new(nil)
      end
    end

  end
end