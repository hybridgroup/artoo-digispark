require 'artoo/commands/install'

module Artoo
  module Commands
    class Digispark < Commands
      package_name "digispark"

      desc "littlewire", "Installs littlewire firmware"
      def littlewire
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

    class Install < Commands
      register Digispark, 'digispark', 'digispark [SUBCOMMAND]', 'Installs firmware on a Digispark'
    end
  end
end