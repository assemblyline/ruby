require "spec_helper"
require "assemblyline/ruby"

RSpec.describe Assemblyline::Ruby do
  it "has a version number" do
    expect(Assemblyline::Ruby::VERSION).not_to be nil
  end
end
