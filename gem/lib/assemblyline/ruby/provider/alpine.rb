module Assemblyline
  module Ruby
    module Provider
      class Alpine
        def current_packages
          `apk info -s`.split("\n")
        end

        def install(packages)
          fail unless system "apk add --no-cache #{packages.join(" ")}"
        end

        def remove(packages)
          fail unless system "apk del #{packages.join(" ")}"
        end

        def required_packages
          `scanelf --needed --nobanner --recursive /usr/local/bundle`.split("\n")
            .map { |row| row.split[1].split(",") }
            .flatten
            .map { |file| `apk info --installed so:#{file}`.chomp }
            .uniq.sort
        end
      end
    end
  end
end
