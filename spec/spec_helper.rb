require 'rubygems'
require 'simplecov'
SimpleCov.start do 
end

require 'pattern_matcher' # and any other gems you need

#require 'factory_girl'
#FactoryGirl.find_definitions

RSpec.configure do |config|
  config.before(:each) do
    
    PatternMatcher.configure do |config|
      config.patterns_yml = File.join(File.dirname(__FILE__), "config", "patterns.yml")
    end

  end
end

def random_word(length = 6)
  (0...length-1).map{ ('a'..'z').to_a[rand(26)] }.join
end

def random_number_string(length = 10)
  (0...length).map{ ('0'..'9').to_a[rand(10)] }.join
end

def sample_yaml_pattern()
  {"name"=>"Social Security Number", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"Socials are private."}
end