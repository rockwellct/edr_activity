module EdrActivity
  module Runner
    class Base
      attr_accessor :config

      def self.run(config)
        new(config).run
      end

      def initialize(config)
        @config = config
      end

      def logger
        EdrActivity::Logger.active
      end

      def run
        raise "The run method must be defined in the inherited class."
      end
    end
  end
end
