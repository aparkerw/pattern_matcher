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

end