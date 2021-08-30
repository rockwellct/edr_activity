require "socket"

module EdrActivity
  module Runner
    class Network < Base
      def run
        Array.wrap(config).each do |destination|
          with_socket(destination) do |socko|
            socko.send(destination["message"], 0)

            logger.info(
              action_type: "network",
              activity_timestamp: Time.now.utc,
              destination: {
                address: destination["address"],
                port: destination["port"]
              },
              source: {
                address: socko.local_address.ip_address,
                port: socko.local_address.ip_port,
              },
              data_length: destination["message"].length,
              protocol: destination["protocol"]
            )
          end
        end
      end

      private

        def with_socket(config)
          socket = make_socket(config)
          yield(socket)
        ensure
          socket.close if socket
        end

        def make_socket(config)
          case config["protocol"]
          when /udp/i
            UDPSocket.new.tap do |socksy|
              socksy.connect(config["address"], config["port"])
            end
          when /tcp/i
            TCPSocket.new(config["address"], config["port"])
          else
            raise "Unknown protocol specified, #{config["protocol"]}"
          end
        end
    end
  end
end
