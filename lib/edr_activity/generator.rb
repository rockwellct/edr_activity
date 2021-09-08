require "active_support/core_ext/array"

module EdrActivity
  class Generator
    attr_accessor :process_config,
      :file_config,
      :network_config

    def self.run(config)
      new(config).tap do |generator|
        generator.run_all
      end
    end

    def initialize(config)
      runners = config["runners"]
      %w[process file network].each do |runner|
        next unless runners[runner].present?

        send("#{runner}_config=".to_sym, runners[runner])
      end

      EdrActivity::Logger.new(log_path: config["output"]["path"])
    end

    def activity_count
      # Number of processes we'll spawn
      Array.wrap(process_config).length +
      # Number of network connections we'll make
      Array.wrap(network_config).length +
      # Number of file operations (files * 3)
      (file_config["count"] * 3)
    end

    def logger
      EdrActivity::Logger.active
    end

    def run_all
      EdrActivity::Runner::Process.run(process_config)
      EdrActivity::Runner::File.run(file_config)
      EdrActivity::Runner::Network.run(network_config)
    end
  end
end
