module PatternMatcher
  class Matcher

    def self.string_to_regex(string)
      begin
        Regexp.new string if is_valid_regex_string?(string)
      rescue
      end
    end

    def self.match_pattern_in_text(pattern, text)
      return match_regex_in_text(pattern.regex, text) if pattern && is_valid_text?(text)
    end

    def self.match_regex_in_text(regex, text)
      return regex.match text if is_valid_regex?(regex) && is_valid_text?(text)
    end

    private

    def self.is_valid_regex_string?(string)
      !string.nil? && !string.empty? 
    end

    def self.is_valid_regex?(pattern)
      !pattern.nil?
    end

    def self.is_valid_text?(text)
      !text.nil? && !text.empty? 
    end

  end
end