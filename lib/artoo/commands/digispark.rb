require 'artoo/commands/install'

module Artoo
  module Commands
    class Install < Commands
      desc "digispark", "Installs firmware on Digispark devices"
      def digispark
        case os
        when :linux
          say "Hello from linux"
        when :macosx
          say "Hello from the Mac"
        else
          say "OS not yet supported..."
        end
      end
    end
  end
end