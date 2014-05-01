module PatternMatcher
  class Match

    attr_accessor :name, :match

    def initialize(hash)
      if !hash.nil?
        @name = hash[:name]
        @match = hash[:match]
      end
    end
  end
end