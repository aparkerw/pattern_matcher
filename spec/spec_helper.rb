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

def sample_yaml_pattern
  {:pattern_id => "SSN", "name"=>"Social Security Number", "regex"=>"[0-9]{3}-[0-9]{2}-[0-9]{4}", "description"=>"Socials are private.", "valid_examples"=>["111-22-3333","123-45-6789"]}
end

def sample_match_hash
  regex_match = /[0-9]{3}-[0-9]{2}-[0-9]{4}/.match("333-22-4444")
  {:name => "Social Security Number", :regex_match=>regex_match}
end