require "spec_helper"
require "assemblyline/ruby/provider"

RSpec.describe Assemblyline::Ruby::Provider do
  let(:platform) { Assemblyline::Ruby::Platform.new(fixture) }
  before { allow(Assemblyline::Ruby::Platform).to receive(:new).and_return(platform) }

  context "a directly supported platform" do
    let(:fixture) { "spec/fixtures/os-release/alpine" }

    it "returns the correct provider" do
      expect(subject.provider).to be_a(Assemblyline::Ruby::Provider::Alpine)
    end
  end

  context "an inplicitly supported platform" do
    let(:fixture) { "spec/fixtures/os-release/ubuntu" }

    it "returns the correct provider" do
      expect(subject.provider).to be_a(Assemblyline::Ruby::Provider::Debian)
    end
  end

  context "an unsupported platform" do
    let(:fixture) { "spec/fixtures/os-release/foo" }

    it "fails" do
      expect { subject.provider }.to raise_error "Platform: foo not supported"
    end
  end
end
