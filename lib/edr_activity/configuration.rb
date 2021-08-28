require "fileutils"
require "yaml"

module EdrActivity
  class Configuration
    attr_accessor :current

    def self.load(path)
      new(path)
    end

    def initialize(path)
      @current = Psych.load(File.read(path))

      Validator.validate(@current)
    end
  end
end
