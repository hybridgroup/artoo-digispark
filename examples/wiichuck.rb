require 'littlewire'
require 'artoo'

connection :digispark, :adaptor => :littlewire, :vendor => 0x1781, :product => 0x0c9f
device :board, :driver => :device_info
device :wiichuck, :driver => :wiichuck, :connection => :arduino, :interval => 0.1

work do
  on wiichuck, :c_button => proc { puts "c button pressed!" }
  on wiichuck, :z_button => proc { puts "z button pressed!" }
  on wiichuck, :joystick => proc { |*value|
    puts "joystick x: #{value[1][:x]}, y: #{value[1][:y]}"
  }

  puts "Firmware name: #{board.firmware_name}"
  puts "Firmware version: #{board.version}"
end

