require "assemblyline/ruby/provider"
require "assemblyline/ruby/system_packages"

module Assemblyline
  module Ruby
    class Installer
      def initialize(provider = nil, system_packages = nil)
        @provider = provider || Provider.provider
        @system_packages = system_packages || SystemPackages.new
        @base_packages = @provider.current_packages
      end

      def install
        provider.install(system_packages.all) if system_packages.any?
        yield
        provider.remove(removable_packages) if system_packages.any?
      end

      private

      attr_reader :provider, :base_packages, :system_packages

      def removable_packages
        provider.current_packages -
          provider.required_packages -
          system_packages.runtime -
          base_packages
      end
    end
  end
end
