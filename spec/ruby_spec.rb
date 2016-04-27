require 'serverspec'

describe 'Ruby' do
  let(:ruby)     { Ruby.new(self) }
  let(:packages) { Packages.new(self) }

  it 'installs version 2.3.1', :'2.3.1' do
    expect(ruby.semvar_version).to eq '2.3.1'
  end

  it 'installs version 2.2.5', :'2.2.5' do
    expect(ruby.semvar_version).to eq '2.2.5'
  end

  it 'installs version 2.1.9', :'2.1.9' do
    expect(ruby.semvar_version).to eq '2.1.9'
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
        .command('apt-check')
        .stdout.chomp
        .split(';').first
        .to_i
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
