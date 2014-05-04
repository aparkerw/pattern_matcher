module PatternMatcher
  class Match

    attr_accessor :name, :regex_match

    def initialize(hash)
      if hash.is_a?(Hash)
  		extract_attributes_from_hash hash
      end
    end

    private

    def extract_attributes_from_hash(hash)
    	@name = hash[:name]
        @regex_match = hash[:regex_match]
    end
  end
end