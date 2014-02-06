require 'artoo/commands/commands'

module Artoo
  module Commands
    class Littlewire < Commands
      package_name "littlewire"

      desc "upload", "Uploads littlewire to Digispark devices"
      def upload
        upload_cmd = File.join(File.expand_path(File.dirname(__FILE__)), "littlewireLoader_v13")

        case os
        when :linux
          sleep(5) if copy_udev_rules
          run(upload_cmd)
        when :macosx
          run(upload_cmd)
        else
          say "OS not yet supported..."
        end

      end

      desc "set-udev-rules", "Sets necessary udev-rules in linux systems"
      def set_udev_rules
        copy_udev_rules(true)
      end

      private
      def copy_udev_rules(force = false)

        udev_sys_path = '/etc/udev/rules.d/49-micronucleus.rules'
        udev_bkp_path = File.join(File.expand_path(File.dirname(__FILE__)), "49-micronucleus.rules")

        if !File.file?(udev_sys_path) || force
          run("sudo cp #{ udev_bkp_path } #{ udev_sys_path }")
          true
        else
          false
        end

      end
    end
  end
end

# We need to register the commands in the main artoo CLI so they
# can be picked up when this command file is required.
# The steps needed to register new CLI commands from outside
# artoo are:
# 1. Related command files need to be copied to the artoo install commands.
# 2. We do this with a rake task that is triggered when the gem is installed
#    (see .gemspec file and look for extensions, ext/Rakefile), in the Rakefile
#    we defined a new default class that makes use of an artoo helper class/method
#    Artoo::Commands::Install helper method '.command'; see ext/Rakefile for details.
# 3. Finally in our main command file (THIS FILE) we open the artoo CLI::Root class to register
#    the new commands.
#
module CLI
  class Root
    desc "littlewire SUBCOMMAND", "Uploads littlewire protocol to digispark"
    subcommand "littlewire", Artoo::Commands::Littlewire
  end
end
