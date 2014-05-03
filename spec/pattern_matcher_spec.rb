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
      PatternMatcher.proof_patterns.should == [[],[]]
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

end