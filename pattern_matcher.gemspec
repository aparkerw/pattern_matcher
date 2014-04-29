$:.push File.expand_path("../lib", __FILE__)
require 'pattern_matcher/version'

Gem::Specification.new do |gem|
  gem.name        = 'pattern_matcher'
  gem.version     = PatternMatcher::VERSION
  gem.licenses    = ['MIT']
  gem.summary     = "Gem to help manage, test and run common string patterns."
  gem.description = "Gem to help manage, test and run common string patterns."
  gem.authors     = ["Adam Parker"]
  gem.email       = 'adam.parker@careerbuilder.com'
  gem.files       = ["lib/pattern_matcher.rb"]
  gem.homepage    = 'https://rubygems.org/gems/pattern_matcher'

  gem.add_development_dependency "rspec", ">= 2.14.1"
  gem.add_development_dependency "rake", ">= 10.3.1"
  gem.add_development_dependency "simplecov", ">= 0.8.2"
end
