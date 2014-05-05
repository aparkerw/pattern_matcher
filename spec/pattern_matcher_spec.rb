require 'spec_helper'

module PatternMatcher
  describe "::configure" do
    it "should throw an ENOENT error when loading missing yaml (file missing)" do
      expect { 
        PatternMatcher.configure do |config|
          config.patterns_yml = File.join(File.dirname(__FILE__), "config", "missing_file.yml")
        end 
      }.to raise_error
    end
  end
  describe "::proof_patterns" do
    it "the default patterns yaml file should match pattern examples" do
      PatternMatcher.proof_patterns.should == {}
    end
    it "should show failing patterns" do
      PatternMatcher.add_pattern_hash({:pattern_id => "SSNFail", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"SSN", "valid_examples"=>["111-22-3333","invalid example"]})
      PatternMatcher.proof_patterns.should == {"SSNFail" => ["invalid example"]}
    end
  end

  describe "::match_patterns_to_text" do
    it "should return [] if there are no matches in the text" do
      PatternMatcher.match_patterns_to_text("here is a social: 333-22-4444").length.should == 1
    end
    it "should return [] if there are no matches in the text" do
      PatternMatcher.match_patterns_to_text("abc 123 4567").should == []
    end
  end

  describe "::patterns" do
    it "should return the patterns form the yaml file" do
      PatternMatcher.patterns.count.should == 2
      PatternMatcher.patterns.keys.should == ["SSN", "UserDID"]
    end
  end

  describe "::add_pattern_hash" do
    it "should add a valid hash" do
        count_before = PatternMatcher.patterns.count
        PatternMatcher.add_pattern_hash({:pattern_id => "SSN2", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"SSN", "valid_examples"=>["111-22-3333"]})
        PatternMatcher.patterns.count.should == count_before + 1
    end
    it "should not add a duplicate hash key" do
        count_before = PatternMatcher.patterns.count
        PatternMatcher.add_pattern_hash({:pattern_id => "SSN", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"SSN", "valid_examples"=>["111-22-3333"]})
        PatternMatcher.patterns.count.should == count_before
    end
  end

end