module PatternMatcher
  class PatternManager

    attr_accessor :patterns_hash

    def self.initialize_patterns
      raw_pattern_hash = load_yaml || {}
      PatternManager.new_from_raw_hash raw_pattern_hash
    end

    def self.new_from_raw_hash(raw_hash)
      patterns = {}
      hash_patterns(raw_hash).each_pair do |a_key, a_pattern|
        a_pattern[:pattern_id] = a_key
        patterns[a_key] = PatternMatcher::Pattern.new(a_pattern)
      end
      PatternManager.new(patterns)
    end

    def initialize(pattern_hash)
      @patterns_hash = pattern_hash
    end

    def keys
      @patterns_hash.keys
    end

    def to_s
      ret_str = ""
      @patterns_hash.values.each do |pattern|
        ret_str += pattern.to_s + "\n"
      end
      ret_str
    end

    def to_a
      @patterns_hash.values
    end

    def each
      @patterns_hash.values.each do |pattern|
        yield pattern
      end
    end

    def count
      @patterns_hash.keys.count || 0
    end

    private

    def self.load_yaml
      YAML.load_file(PatternMatcher.configuration.patterns_yml) if PatternMatcher.configuration.patterns_yml
    end

    def self.hash_patterns(hash)
        (hash["patterns"] || {}) if !hash.nil?
    end
  end
end