require 'yaml'
require 'date'

#gem includes

require "pattern_matcher/version"
require "pattern_matcher/config"
require "pattern_matcher/pattern"
require "pattern_matcher/matcher"

module PatternMatcher

  def self.configure
    yield configuration if block_given?
    @patterns = Matcher.initialize_patterns
  end

  def self.configuration
    @configuration ||= PatternMatcher::Config.new
  end

  def self.configured?
    !@configuration.nil?
  end

  def self.proof_patterns
    pattern_errors = []
    @patterns.each do |pattern|
      pattern_errors << pattern.validate_all_examples if pattern.is_valid?
    end
    pattern_errors
  end

end

