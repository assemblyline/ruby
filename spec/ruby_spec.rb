require 'serverspec'

describe 'Ruby' do
  let(:ruby)     { Ruby.new(self) }
  let(:packages) { Packages.new(self) }

  it 'installs version 2.2.2', :'2.2.2' do
    expect(ruby.semvar_version).to eq '2.2.2'
  end

  it 'installs version 2.2.1', :'2.2.1' do
    expect(ruby.semvar_version).to eq '2.2.1'
  end

  it 'installs version 2.2.0', :'2.2.0' do
    expect(ruby.semvar_version).to eq '2.2.0'
  end

  it 'installs version 2.1.6', :'2.1.6' do
    expect(ruby.semvar_version).to eq '2.1.6'
  end

  it 'installs version 2.1.5', :'2.1.5' do
    expect(ruby.semvar_version).to eq '2.1.5'
  end

  it 'installs version 2.0.0-p643', :'2.0.0-p645' do
    expect(ruby.full_version).to eq '2.0.0p645'
  end

  it 'installs version 2.0.0-p643', :'2.0.0-p643' do
    expect(ruby.full_version).to eq '2.0.0p643'
  end

  it 'installs version 1.9.3-p551', :'1.9.3-p551' do
    expect(ruby.full_version).to eq '1.9.3p551'
  end

  describe 'bundler' do
    it 'is installed' do
      expect(ruby.gem_installed('bundler')).to be_truthy
    end
  end

  it 'does not need packge upgrades' do
    expect(packages.to_upgrade).to eq 0
  end

  class Packages
    def initialize(context)
      @context = context
    end

    def to_upgrade
      context
        .command('apt-get clean && apt-get update && apt-get upgrade --dry-run')
        .stdout
        .match(/^(\d+) upgraded, (\d+) newly installed, (\d+) to remove and (\d+) not upgraded\.$/)[1].to_i
    end

    private

    attr_reader :context
  end

  class Ruby
    def initialize(context)
      @context = context
    end

    def gem_installed(gem)
      context.command('gem list').stdout.include?(gem)
    end

    def semvar_version
      full_version.split('p').first
    end

    def full_version
      version_string.split[1]
    end

    private

    def version_string
      context.command('ruby -v').stdout
    end

    attr_reader :context
  end
end
