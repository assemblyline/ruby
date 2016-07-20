require "spec_helper"
require "assemblyline/ruby/installer"

RSpec.describe Assemblyline::Ruby::Installer do
  let(:provider) { double(:provider) }
  let(:thingy)   { double(:thingy) }
  subject { described_class.new(provider) }

  describe "#install" do
    it "calls the provider and yeilds controll in the correct order" do
      expect(provider).to receive(:install).ordered
      expect(thingy).to receive(:foo).ordered
      expect(provider).to receive(:remove).ordered

      subject.install { thingy.foo }
    end
  end
end
