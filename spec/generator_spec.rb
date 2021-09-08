RSpec.shared_examples "generator" do |config_path|
  let(:config) { EdrActivity::Configuration.load(config_path) }

  context "#config_file" do
    it "has a valid config" do
      expect(Pathname.new(config_path)).to exist
      expect(Pathname.new(config_path)).to be_file
      expect(config.class).to equal(EdrActivity::Configuration)
    end
  end

  context "#run" do
    let(:gen) { EdrActivity::Generator.run(config.current) }
    let(:log_file) { gen.logger.filename }
    after(:each) { File.unlink(log_file) }

    it "generates a log file" do
      expect(Pathname.new(log_file)).to exist
      expect(Pathname.new(log_file)).to be_file
    end

    it "has the correct number of lines in the log file" do
      lines = JSONL.parse(File.read(log_file))
      expect(gen.activity_count).to equal(lines.length)
    end
  end
end

RSpec.describe EdrActivity::Generator do
  context "with the individual activity config file" do
    include_examples "generator", "spec/fixtures/configs/config_single.yml"
  end

  context "with the multiple activity config file" do
    include_examples "generator", "spec/fixtures/configs/config_multi.yml"
  end
end
