module PatternMatcher
  class Match

    attr_accessor :name, :regex_match

    def initialize(hash)
      if hash.is_a?(Hash)
        @name = hash[:name]
        @regex_match = hash[:regex_match]
      end
    end
  end
end