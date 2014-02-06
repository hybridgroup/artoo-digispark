# Artoo Adaptor For Digispark

This repository contains the Artoo (http://artoo.io/) adaptor for the Digispark (http://www.kickstarter.com/projects/digistump/digispark-the-tiny-arduino-enabled-usb-dev-board) ATTiny-based USB development board with the Little Wire (http://littlewire.cc/) protocol firmware installed.

Artoo is a open source micro-framework for robotics using Ruby.

For more information abut Artoo, check out our repo at https://github.com/hybridgroup/artoo

[![Code Climate](https://codeclimate.com/github/hybridgroup/artoo-digispark.png)](https://codeclimate.com/github/hybridgroup/artoo-digispark) [![Build Status](https://travis-ci.org/hybridgroup/artoo-digispark.png?branch=master)](https://travis-ci.org/hybridgroup/artoo-digispark)

This gem makes extensive use of the littlewire.rb gem (https://github.com/Bluebie/littlewire.rb) thanks to [@Bluebie](https://github.com/Bluebie)

## Installing

```
gem install artoo-digispark
```

## Using

```ruby
connection :digispark, :adaptor => :littlewire, :vendor => 0x1781, :product => 0x0c9f
device :board, :driver => :device_info
device :led, :driver => :led, :pin => 1

work do
  puts "Firmware name: #{board.firmware_name}"
  puts "Firmware version: #{board.version}"

  every 1.second do
    led.toggle
  end
end
```

## Devices supported

The following hardware devices have driver support, via the artoo-gpio gem:
- Button
- LED
- Maxbotix ultrasonic range finder
- Analog sensor
- Motor (DC)
- Servo

The following hardware devices have driver support, via the artoo-i2c gem:
- Wiichuck controller
- Wiiclassic controller

## Connecting to Digispark

Connecting to the Digispark (http://www.kickstarter.com/projects/digistump/digispark-the-tiny-arduino-enabled-usb-dev-board)
ATTiny-based USB development board is very easy using Artoo; Artoo uses the littlewire (http://littlewire.cc/) protocol firmware
to communicate with the digispark and includes CLI commands to make installation a breeze, after littlewire is installed you 
can connect right away with Artoo.

### OSX

The main steps are:
- Install the artoo-digispark gem
- Upload the Littlewire protocol to the digispark
- Connect to the device via Artoo

DO NOT plug in the Digispark to your computer's USB port until prompted.

Install the artoo-digispark gem:

```
$ gem install artoo-digispark
```

After installing the artoo-digispark gem run the following command to
upload littlewire to the digispark, plug it in to a USB port when
prompted:

```
$ artoo littlewire upload
```

Once plugged in, use the `artoo connect scan` command with the  `-t usb` option to verify your connection info:

```
$ artoo connect scan -t usb
```

Now use the `ID` info returned to find the `product` and `vendor` ID's for the connection info Digispark in your Artoo code.

That is it, you are set to start running Artoo digispark examples.

### Ubuntu

The main steps are:
- Add a udev rule to allow access to the Digispark device
- Plug in the Digispark to the USB port
- Connect to the device via Artoo


DO NOT plug in the Digispark to your computer's USB port until prompted.

Install the artoo-digispark gem:

```
$ gem install artoo-digispark
```

After installing the artoo-digispark gem run the following command to
upload littlewire to the digispark, plug it in to a USB port when
prompted, you might be asked to enter your sudo password, since
uploading littlewire to the digispark requires some new udev rules, you
can check and review them in /etc/udev/rules.d/49-micronucleus.rules
after running the `artoo littlewire upload` command):

```
$ artoo littlewire upload
```

That is it, you are set to start running Artoo digispark examples.

Thanks to [@bluebie](https://github.com/Bluebie) for the help with udev rules used when uploading littlewire to the digispark! (https://github.com/Bluebie/micronucleus-t85/wiki/Ubuntu-Linux)

Once plugged in, use the `artoo connect scan` command with the  `-t usb` option to verify your connection info:

```
$ artoo connect scan -t usb
```

Now use the `ID` info returned to find the `product` and `vendor` ID's for the connection info Digispark in your Artoo code.

### Windows

We are currently working with the Celluloid team to add Windows support. Please check back soon!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
