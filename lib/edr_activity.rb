require "pry"
require "active_support"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module EdrActivity
end
