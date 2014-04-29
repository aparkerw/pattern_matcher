module PatternMatcher
  class Pattern

    attr_accessor :name, :regex_string, :description, :valid_examples
    attr_accessor :regex

    def initialize(hash)
      if !hash.nil?
        @name = hash["name"]
        @regex_string = hash["regex"]
        @regex = Matcher.string_to_regex(@regex_string)
        @description = hash["description"]
        @valid_examples = hash["valid_examples"] || []
      end
    end

    def validate_all_examples
      failures = []
      @valid_examples.each do |example|
        failures << example if !example_valid? example
      end
      failures
    end

    def self.example_valid?(example)
      Matcher.match_pattern_in_text(@regex, example)
    end

    def is_valid?
        return !@regex.nil?
    end
  end
end