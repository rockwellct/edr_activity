require_relative "lib/edr_activity/version"

Gem::Specification.new do |spec|
  spec.name          = "edr_activity"
  spec.version       = EdrActivity::VERSION
  spec.authors       = ["Casey Rockwell"]
  spec.email         = ["casey@rockwell.dev"]

  spec.summary       = <<~SUMMARY
    Test EDR builds by generating and logging activity for comparison
  SUMMARY
  spec.description   = "Utility to generate activity for EDR validation"
  spec.homepage      = "https://github.com/rockwellct/edr_activity"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables  << "eag"
  spec.require_paths = ["lib"]
  # runtime gems
  spec.add_runtime_dependency "activesupport", "~> 6.1"
  spec.add_runtime_dependency "rxrb", "~> 0.1"
  # development gems
  spec.add_development_dependency "pry", "~> 0.14.1"
end
