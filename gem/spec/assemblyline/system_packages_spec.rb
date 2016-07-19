require "spec_helper"
require "assemblyline/ruby/system_packages"

RSpec.describe Assemblyline::Ruby::SystemPackages do
  subject do
    described_class.new(
      [
        {
          "name" => "json",
          "build" => ["build-base"],
        },
        {
          "name" => "mysql2",
          "build" => ["mariadb-dev"],
        },
        {
          "name" => "pg",
          "build" => ["build-base", "postgresql-dev"],
        },
      ],
    )
  end

  context "with a listed package" do
    it "lists the build deps" do
      Dir.chdir("spec/fixtures/bundler/listed") do
        expect(subject.build).to eq ["build-base", "postgresql-dev"]
      end
    end

    context "and some unlisted ones" do
      let(:packages) { %w(pg rake) }

      it "lists the build deps" do
        Dir.chdir("spec/fixtures/bundler/both") do
          expect(subject.build).to eq ["build-base", "postgresql-dev"]
        end
      end
    end

    context "no explicit rundeps" do
      it "empty run deps" do
        Dir.chdir("spec/fixtures/bundler/both") do
          expect(subject.runtime).to eq []
        end
      end
    end
  end

  context "with different deps" do
    it "lists the build deps" do
      Dir.chdir("spec/fixtures/bundler/json") do
        expect(subject.build).to eq ["build-base"]
      end
    end
  end

  context "with no deps" do
    it "lists the build deps" do
      Dir.chdir("spec/fixtures/bundler/none") do
        expect(subject.build).to eq []
      end
    end
  end

  context "with a gem installed from git" do
    it "adds git to the buildeps" do
      Dir.chdir("spec/fixtures/bundler/git") do
        expect(subject.build).to include("git")
      end
    end
  end
end
