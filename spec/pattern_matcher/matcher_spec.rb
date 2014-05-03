require 'spec_helper'

module PatternMatcher
  describe Matcher do
  
    describe "::string_to_regex" do
      it "should return nil when given nil" do
        Matcher.string_to_regex(nil).should be_nil
      end

      it "should return nil when given ''" do
        Matcher.string_to_regex('').should be_nil
      end

      it "should return a functional regex when given a valid string" do
        returned_regex = Matcher.string_to_regex('^[0-9]$')
        returned_regex.should eql(/^[0-9]$/)
        returned_regex.match('6').should be_true
      end

      it "should return nil when regex string is invalid" do
        returned_regex = Matcher.string_to_regex('afsda.+-f/\///\\')
        returned_regex.should be_nil
      end
    end

    describe "::match_pattern_in_text" do
      before(:each) do
        
        @pattern = Pattern.new({"regex" => "hello"})

      end
      it "should return nil when given nil pattern and nil text" do
        Matcher.match_pattern_in_text(nil, nil).should be_false
      end

      it "should return nil when given nil pattern and valid text" do
        Matcher.match_pattern_in_text(nil, "hello world").should be_false
      end

      it "should return nil when given valid pattern and nil text" do
        Matcher.match_pattern_in_text(@pattern, nil).should be_false
      end

      it "should match when pattern is in text" do
        Matcher.match_pattern_in_text(@pattern, "hello world").should be_true
      end

      it "should not match when pattern is not in text" do
        Matcher.match_pattern_in_text(@pattern, "goodbye world").should be_false
      end
    end

    describe "::match_regex_in_text" do
      it "should return nil when given nil regex and nil text" do
        Matcher.match_regex_in_text(nil, nil).should be_false
      end

      it "should return nil when given nil regex and valid text" do
        Matcher.match_regex_in_text(nil, "hello world").should be_false
      end

      it "should return nil when given valid regex and nil text" do
        Matcher.match_regex_in_text(/hello/, nil).should be_false
      end

      it "should match when regex is in text" do
        Matcher.match_regex_in_text(/hello/, "hello world").should be_true
      end

      it "should not match when regex is not in text" do
        Matcher.match_regex_in_text(/hello/, "goodbye world").should be_false
      end
    end

    describe "::initialize_patterns" do
      it "should return {} if config is incorrectly initialized (no pattern yaml set)" do
        PatternMatcher.configure do |config|
          config.patterns_yml = nil
        end
        Matcher.initialize_patterns.should == []
      end
      it "should return an array of pattern objects" do
        Matcher.initialize_patterns.should_not == {}
      end
    end

  end
end