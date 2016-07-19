require "spec_helper"
require "assemblyline/ruby/platform"

RSpec.describe Assemblyline::Ruby::Platform do
  context "alpine" do
    subject { described_class.new("spec/fixtures/os-release/alpine") }

    it "parses the ID" do
      expect(subject.id).to eq "alpine"
    end

    it "parses the VERSION_ID" do
      expect(subject.version).to eq "3.4.0"
    end

    it "parses the PRETTY_NAME" do
      expect(subject.to_s).to eq "Alpine Linux v3.4"
    end
  end

  context "ubuntu" do
    subject { described_class.new("spec/fixtures/os-release/ubuntu") }

    it "parses the ID" do
      expect(subject.id).to eq "ubuntu"
    end

    it "parses ID_LIKE" do
      expect(subject.like).to eq "debian"
    end

    it "parses the VERSION_ID" do
      expect(subject.version).to eq "16.04"
    end

    it "parses the PRETTY_NAME" do
      expect(subject.to_s).to eq "Ubuntu 16.04 LTS"
    end
  end
end
