require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

RSpec.configure(&:disable_monkey_patching!)
