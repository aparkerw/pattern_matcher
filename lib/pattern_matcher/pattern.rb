module PatternMatcher
  class Pattern

    attr_accessor :pattern_id, :name, :regex_string, :description, :valid_examples
    attr_accessor :regex

    def initialize(hash)
      if hash.is_a?(Hash)
        @pattern_id = hash[:pattern_id]
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
        failures << example if !pattern_example_valid? example
      end
      failures
    end

    def to_s
      "#{@name} (#{is_valid?}) -- #{@regex_string} -- #{@description}"
    end

    def to_h
      {
        :name => @name,
        :is_valid => is_valid?,
        :regex_string => @regex_string,
        :description => @description,
        :valid_examples => @valid_examples
      }
    end

    def is_valid?
        return !@regex.nil? && !@pattern_id.nil?
    end

    def pattern_example_valid?(example)
      Matcher.match_regex_in_text(@regex, example)
    end
  end
end