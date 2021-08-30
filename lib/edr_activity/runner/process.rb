module EdrActivity
  module Runner
    class Process < Base
      def run
        Array.wrap(config).each do |process|
          process_command = [
            process['command'],
            process['arguments']
          ].flatten.join(" ")

          proc_start_time = Time.now.utc
          proc_pid = spawn(process_command, [:out, :err] => ::File::NULL)

          logger.info(
            process_id: proc_pid,
            action_type: "process",
            start_timestamp: proc_start_time
          )
        end
      end
    end
  end
end
