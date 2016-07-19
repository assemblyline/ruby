require "spec_helper"
require "assemblyline/ruby/installer"

RSpec.describe Assemblyline::Ruby::Installer do
  let(:provider) { MockProvider.new }

  let(:system_packages) do
    Assemblyline::Ruby::SystemPackages.new(
      [
        {
          "name" => "pg",
          "build" => ["build-base", "postgresql-dev"],
          "runtime" => ["booop"],
        },
      ],
    )
  end

  subject { described_class.new(provider, system_packages) }

  describe "#install" do
    it "installs the required packages" do
      Dir.chdir("spec/fixtures/bundler/listed") do
        expect(provider).to receive(:install).with(["build-base", "postgresql-dev", "booop"]).and_call_original
        expect(provider).to receive(:remove).with(["build-base", "postgresql-dev"]).and_call_original
        subject.install {}
      end
    end

    context "when no packages are needed" do
      it "does not install anything" do
        Dir.chdir("spec/fixtures/bundler/none") do
          expect(provider).to_not receive(:install)
          expect(provider).to_not receive(:remove)
          subject.install {}
        end
      end
    end
  end
end

class MockProvider
  def initialize
    @current_packages = %w(foo bar baz)
  end

  attr_reader :current_packages

  def install(packages)
    @current_packages += packages
  end

  def remove(packages)
    @current_packages -= packages
  end

  def required_packages
    []
  end
end
