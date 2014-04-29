module PatternMatcher
  class Config

    attr_accessor :patterns_yml

    def initialize
      set_defaults
    end

    private

    def set_defaults
      @patterns_yml = File.join(File.dirname(__FILE__), "config", "patterns.yml")
    end

  end
end