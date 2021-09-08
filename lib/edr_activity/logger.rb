require "etc"
require "fileutils"
require "log_formatter"
require "log_formatter/ruby_json_formatter"
require "sys/proctable"

module EdrActivity
  class Logger
    include Sys
    attr_accessor :logger

    def initialize(log_path:)
      FileUtils.mkdir_p(log_path)
      file_name = "action_log_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.json"

      @logger = ::Logger.new(File.join(log_path, file_name))
      @logger.level = ::Logger::DEBUG

      @logger.formatter = Ruby::JSONFormatter::Base.new do |config|
        config[:level] = false
        config[:type] = false
        config[:app] = false
      end

      @@active_logger = self
    end

    def self.active
      raise "The logger has not yet been initialized" if @@active_logger.nil?

      @@active_logger
    end

    def info(process_id: Process.pid, **kwargs)
      logger.info(
        kwargs.merge(
          process_info(process_id: process_id)
        )
      )
    end

    def process_info(process_id: Process.pid)
      proc_info = ProcTable.ps(pid: process_id)

      {
        username: Etc.getpwuid(proc_info.euid).name,
        process_name: proc_info.name,
        process_command: proc_info.cmdline,
        process_id: proc_info.pid
      }
    end
  end
end
