require "rxrb"
require "yaml"

module EdrActivity
  class Configuration
    class Validator
      attr_accessor :schema
      def self.validate(config)
        new.validate(config)
      end

      def initialize
        load_schema
      end

      def validate(config)
        schema.check!(config)
      end

      private

        def load_schema
          schema_path = File.join(__dir__, "schemas")
          schema_file = File.join(schema_path, "root.yml")
          schema = Psych.load(File.read(schema_file))

          rx = Rxrb::Rx.new({ :load_core => true })
          %w[process file network].each do |type|
            path = File.join(schema_path, "#{type}_schema.yml")
            meta_schema = Psych.load(File.read(path))
            rx.learn_type(meta_schema["uri"], meta_schema["schema"])
            # puts "  ✅  Learned meta scheme #{meta_schema["uri"]}"
          end

          @schema = rx.make_schema(schema)
        end
    end
  end
end
