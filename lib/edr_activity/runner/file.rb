module EdrActivity
  module Runner
    class File < Base
      def run
        file_list = create_files(
          path: config["path"],
          count: config["count"],
          extension: config["extension"]
        )

        modify_files(files: file_list)
        delete_files(files: file_list)
      end

      private

        def create_files(path: "tmp", count: 1, extension: ".tmp")
          FileUtils.mkdir_p(path)

          (1..count).map do
            file = Tempfile.new(["edr_testing", extension], path)

            logger.info(
              action_type: "file",
              activity_timestamp: Time.now.utc,
              file_path: ::File.expand_path(file.path),
              action: "create"
            )

            file
          end
        end

        def modify_files(files: [])
          files.each_with_index do |file, i|
            open(file.path, "a") { |fs| fs.puts "Adding stuff step #{i}" }

            logger.info(
              action_type: "file",
              activity_timestamp: Time.now.utc,
              file_path: ::File.expand_path(file.path),
              action: "modify"
            )
          end
        end

        def delete_files(files: [])
          files.each do |file|
            logger.info(
              action_type: "file",
              activity_timestamp: Time.now.utc,
              file_path: ::File.expand_path(file.path),
              action: "delete"
            )

            file.unlink
          end
        end
    end
  end
end
