require "assemblyline/ruby/system_packages"

module Assemblyline
  module Ruby
    module Provider
      class Alpine
        def initialize(system_packages = SystemPackages.new)
          @system_packages = system_packages
        end

        def install
          add ".a10e.builddeps", system_packages.all
        end

        def remove
          add ".a10e.rundeps", rundeps
          del ".a10e.builddeps"
        end

        private

        def rundeps
          system_packages.runtime + required_packages
        end

        def required_packages
          `scanelf --needed --nobanner --recursive /usr/local/bundle`.split("\n")
            .map { |row| row.split[1].split(",") }
            .flatten
            .map { |file| `apk info --installed so:#{file}`.chomp }
            .uniq.sort
        end

        def add(virtual_package, packages)
          puts "installing virtual package: #{virtual_package}"
          puts "============="
          package.each { |pkg| puts pkg }
          cmd "apk add --no-cache --virtual #{virtual_package} #{packages.join(" ")}"
        end

        def del(package)
          puts "removing package: #{package}"
          cmd "apk del #{package}"
        end

        def cmd(command)
          fail unless system command
        end
      end
    end
  end
end
