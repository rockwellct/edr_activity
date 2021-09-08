RSpec.describe EdrActivity::Logger do
  let(:logger) { EdrActivity::Logger.new(log_path: "tmp/logs") }
  let(:msg) { logger.build_message(message: "Boo hoo") }
  after(:each) { File.unlink(logger.filename) }

  %i[
    message
    username
    process_name
    process_command
    process_id
  ].each do |key_name|
    it "includes the expected key with a value" do
      expect(msg.key?(key_name)).to be(true)
      expect(msg[key_name]).to be_truthy
    end
  end
end
