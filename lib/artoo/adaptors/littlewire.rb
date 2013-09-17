require 'artoo/adaptors/adaptor'

module Artoo
  module Adaptors
    # Connect to Digispark or Littlewire device using Little Wire protocol
    # @see http://littlewire.cc/
    class Littlewire < Adaptor
      attr_reader :littlewire, :vendor, :product, :usb, :firmware_version

      def initialize(params={})
        super

        params[:additional_params] ||= {}
        @vendor = params[:additional_params][:vendor] || 0x1781
        @product = params[:additional_params][:product] || 0x0c9f
      end

      # Creates connection with littlewire board
      # @return [Boolean]
      def connect
        require 'littlewire' unless defined?(::LittleWire)
        @littlewire = ::LittleWire.new(connect_to_usb)
        super
        return true
      end

      # Closes connection with littlewire board
      # @return [Boolean]
      def disconnect
        littlewire.finished
        super
      end

      # Returns name of littlewire board
      # @return [String]
      def firmware_name
        "Little Wire"
      end

      # Returns version of littlewire board
      # @return [String]
      def version
        @firmware_version ||= littlewire.version
      end

      # GPIO - digital interface
      def digital_read(pin)
        littlewire.digital_write(pin, true)
        littlewire.digital_read(pin)
      end

      def digital_write(pin, val)
        littlewire.pin_mode(pin, :output)
        littlewire.digital_write(pin, val)
      end

      # GPIO - analog interface
      def analog_read(pin)
        littlewire.analog_read(analog_pin(pin)) * 1000.0
      end

      # GPIO - PWM interface
      def pwm_write(pin, level)
        littlewire.hardware_pwm_write(pin, level)
      end

      # GPIO - servo interface
      def servo_write(pin, level)
        littlewire.servo_write(pin, level - 90)
      end

      # i2c interface
      def i2c_start(address)
        raise "i2c support requires version 1.3+ of littlewire" unless version >= "1.3"
        @i2c_address = address
        littlewire.i2c.delay = 10
      end

      def i2c_end
      end

      def i2c_read(size)
        littlewire.i2c.start(@i2c_address, :read)
        val = littlewire.i2c.read(size, true)
        val
      end

      def i2c_write(*data)
        littlewire.i2c.start(@i2c_address, :write)
        littlewire.i2c.write(data.to_a, true)
      end

      def connect_to_usb
        @usb = LIBUSB::Context.new.devices(
          :idVendor  => vendor,
          :idProduct => product
        ).first
      end

      def analog_pin(pin)
        case pin
        when 5
          0
        when 2
          1
        else
          raise "Invalid pin" # TODO: raise exception class
        end
      end

      # Uses method missing to call Littlewire methods
      # @see https://github.com/Bluebie/littlewire.rb
      def method_missing(method_name, *arguments, &block)
        littlewire.send(method_name, *arguments, &block)
      end
    end
  end
end
