require 'spec_helper'

module PatternMatcher
  describe Pattern do
  
    describe "::initialize" do
      it "should work given a valid hash" do
        a_pattern = Pattern.new(sample_yaml_pattern)
        a_pattern.pattern_id.should == sample_yaml_pattern[:pattern_id]
        a_pattern.name.should == sample_yaml_pattern["name"]
        a_pattern.regex_string.should == sample_yaml_pattern["regex"]
        a_pattern.regex.should == Matcher.string_to_regex(sample_yaml_pattern["regex"])
        a_pattern.description.should == sample_yaml_pattern["description"]
        a_pattern.is_valid?.should be_true
      end

      it "should behave correctly given {}" do
        a_pattern = Pattern.new({})
        a_pattern.is_valid?.should be_false
      end

      it "should behave correctly given ''" do
        a_pattern = Pattern.new('')
        a_pattern.is_valid?.should be_false
      end

      it "should behave correctly given nil" do
        a_pattern = Pattern.new(nil)
        a_pattern.is_valid?.should be_false
      end

      it "should behave correctly without a :pattern_id" do
        a_pattern = Pattern.new({"name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"desc", "valid_examples"=>["111-22-4444","aaa"]})
        a_pattern.is_valid?.should be_false
      end
    end

    describe ".validate_all_examples" do
      it "should return empty array [] if all tests pass" do
        pattern = Pattern.new(sample_yaml_pattern)
        pattern.validate_all_examples.should == []
      end

      it "should return an array with failures" do
        pattern = Pattern.new({:pattern_id => "SSN", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"desc", "valid_examples"=>["111-22-4444","aaa"]})
        pattern.validate_all_examples.should == ['aaa']
      end

      it "should return an array with failures (multiple)" do
        pattern = Pattern.new({:pattern_id => "SSN", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"desc", "valid_examples"=>["aaa", "333-22-4444", "333-22-333"]})
        pattern.validate_all_examples.should == ['aaa', '333-22-333']
      end

      it "should return an empty array if there are no examples" do
        pattern = Pattern.new({:pattern_id => "SSN", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"desc"})
        pattern.validate_all_examples.should == []
      end

      it "should return an empty array if the examples in the hash is malformed" do
        #todo: how do we test this?
        pattern = Pattern.new({:pattern_id => "SSN", "name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"desc", "valid_examples"=>"this isn't a valid input"})
        pattern.validate_all_examples.should == []
      end
    end

    describe ".pattern_example_valid?" do

      before(:each) do
        @pattern = Pattern.new(sample_yaml_pattern)
      end

      it "should return false if the regex is invalid" do
        @pattern.pattern_example_valid?('111-22-1111').should be_true
      end

      it "should return false if the regex is a missmatch" do
        @pattern.pattern_example_valid?('missmatch').should be_false
      end

      it "should return false if the regex is invalid" do
        @pattern.pattern_example_valid?('missmatch').should be_false
      end

      it "should return false if the pattern is null" do
        @pattern.pattern_example_valid?(nil).should be_false
      end

      it "should return false if the pattern is ''" do
        @pattern.pattern_example_valid?('').should be_false
      end

      it "should return false if the regex is invalid" do
        @pattern = Pattern.new({"name"=>"SSN", "regex"=>"afsda.+-f/\///\\", "description"=>"desc"})
        @pattern.pattern_example_valid?('111-22-1111').should be_false
      end
    end

    describe ".to_s" do
      it "should return a correctly formatted string" do
        pattern = Pattern.new(sample_yaml_pattern)
        pattern.to_s.should == "#{pattern.name} (#{pattern.is_valid?}) -- #{pattern.regex_string} -- #{pattern.description}"
      end
      it "should gracefully handle no name" do
        pattern = Pattern.new({"regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"Description here."})
        pattern.to_s.should == "#{pattern.name} (#{pattern.is_valid?}) -- #{pattern.regex_string} -- #{pattern.description}"
      end
      it "should gracefully handle no regex" do
        pattern = Pattern.new({"name"=>"SSN", "description"=>"desc"})
        pattern.to_s.should == "#{pattern.name} (#{pattern.is_valid?}) -- #{pattern.regex_string} -- #{pattern.description}"
      end
      it "should gracefully handle no description" do
        pattern = Pattern.new({"name"=>"SSN", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}"})
        pattern.to_s.should == "#{pattern.name} (#{pattern.is_valid?}) -- #{pattern.regex_string} -- #{pattern.description}"
      end
    end

    describe ".to_h" do
      before(:each) do
        @pattern = Pattern.new(sample_yaml_pattern)
      end

      it "should return a correct hash" do
        @pattern.to_h.should == {:name => @pattern.name, :is_valid => @pattern.is_valid?, :regex_string => @pattern.regex_string, :description => @pattern.description, :valid_examples => @pattern.valid_examples}
      end
    end

  end
end