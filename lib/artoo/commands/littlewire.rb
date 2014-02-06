require 'artoo/commands/commands'

module Artoo
  module Commands
    class Littlewire < Commands
      package_name "littlewire"

      desc "upload", "Uploads littlewire to Digispark devices"
      option :version, :aliases => "-v", :default => "1.2", :desc => "Version of littlewire protocol to install"
      def upload
        upload_cmd = File.join(File.expand_path(File.dirname(__FILE__)), "deps/littlewireLoader_v13")

        case os
        when :linux
          if copy_udev_rules
            sleep(5)
          end
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
        udev_bkp_path = File.join(File.expand_path(File.dirname(__FILE__)), "deps/49-micronucleus.rules")

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
