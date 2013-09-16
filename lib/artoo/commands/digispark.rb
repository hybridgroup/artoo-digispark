require 'artoo/commands/install'

module Artoo
  module Commands
    class Install < Commands
      desc "digispark", "Installs firmware on Digispark devices"
      option :version, :aliases => "-v", :default => "1.2", :desc => "Version of firmware to install"
      def digispark
        case os
        when :linux
          # TODO: install the udev rules file
          run("littlewire.rb install #{options[:version]}")
        when :macosx
          run("littlewire.rb install #{options[:version]}")
        else
          say "OS not yet supported..."
        end
      end
    end
  end
end