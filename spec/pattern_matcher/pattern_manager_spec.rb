require 'spec_helper'

module PatternMatcher
  describe PatternManager do

    describe "::initialize_patterns" do
      it "should return a blank PatternManager if config is incorrectly initialized (no pattern yaml set)" do
        PatternMatcher.configure do |config|
          config.patterns_yml = nil
        end
        pattern_manager = PatternManager.initialize_patterns
        pattern_manager.count.should_not be_nil
        pattern_manager.count.should == 0
      end
      it "should return an array of pattern objects" do
        PatternMatcher.patterns.should_not be_nil
        PatternMatcher.patterns.count.should == 2
      end
    end

    describe "::new_from_raw_hash" do
      it "should return a valid PatternManager object given a valid raw hash" do
        PatternMatcher.patterns.to_a.count.should == 2
        PatternMatcher.patterns.to_a.first.is_a?(PatternMatcher::Pattern).should be_true
      end
      it "should gracefully handle no patterns" do
      end
    end

    describe ".add_pattern" do
      it "should return a valid PatternManager object given a valid raw hash" do
        PatternMatcher.patterns.to_a.count.should == 2
        PatternMatcher.patterns.to_a.first.is_a?(PatternMatcher::Pattern).should be_true
      end
      it "should gracefully handle no patterns" do
      end
    end

    describe ".to_a" do
      it "should return an array of the patterns Matcher knows about" do
        PatternMatcher.patterns.to_a.count.should == 2
        PatternMatcher.patterns.to_a.first.is_a?(PatternMatcher::Pattern).should be_true
      end
      it "should gracefully handle no patterns" do
        PatternMatcher.configure do |config|
          config.patterns_yml = nil
        end
        pattern_manager = PatternManager.initialize_patterns
        pattern_manager.count.should == 0
        pattern_manager.to_a.should == []
      end
    end

    describe ".patterns_to_s" do
      it "should return a string of the patterns that Matcher knows to apply" do
        PatternMatcher.patterns.to_s.should == patterns_as_string
      end
      it "should gracefully handle no patterns" do
      end
    end

    def patterns_as_string
      ret_str = ""
      PatternMatcher.patterns.to_a.each do |pattern|
        ret_str += pattern.to_s + "\n"
      end
      ret_str
    end
  end
end