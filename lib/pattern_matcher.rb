require 'yaml'
require 'date'

#gem includes

require "pattern_matcher/version"
require "pattern_matcher/config"
require "pattern_matcher/pattern"
require "pattern_matcher/match"
require "pattern_matcher/matcher"
require "pattern_matcher/pattern_manager"

module PatternMatcher

  def self.configure
    yield configuration if block_given?
    @patterns = PatternManager.initialize_patterns
  end

  def self.configuration
    @configuration ||= PatternMatcher::Config.new
  end

  def self.configured?
    !@configuration.nil?
  end

  def self.match_patterns_to_text(text)
    matches = []
    @patterns.to_a.each do |pattern|
      regex_match = Matcher.match_pattern_in_text(pattern, text)
      matches << Match.new({:name => pattern.name, :regex_match => regex_match}) if regex_match
    end
    matches
  end

  def self.proof_patterns
    pattern_errors = {}
    @patterns.each do |pattern|
      failures = pattern.validate_all_examples
      pattern_errors[pattern.pattern_id] = failures if (pattern.is_valid? && failures.count > 0)
    end
    pattern_errors
  end

  def self.patterns
    @patterns
  end

  def self.add_pattern_hash(hash)
    pattern = Pattern.new(hash)
    @patterns.add_pattern pattern if pattern.is_valid?
  end

end

