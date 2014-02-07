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

Connecting to the Digispark (http://www.kickstarter.com/projects/digistump/digispark-the-tiny-arduino-enabled-usb-dev-board) ATTiny-based USB development board is very easy using Artoo, first we need to install the littlewire (http://littlewire.cc/) protocol to communicate with the digispark, Artoo includes CLI commands to make the process of uploading littlewire to the digispark as simple as possible, after littlewire has been uploaded you can connect and communicate using Artoo.

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

After installing the artoo-digispark gem run the following command to upload littlewire to the digispark, plug it to a USB port when prompted:

```
$ artoo littlewire upload
```

Once plugged in, use the `artoo connect scan` command with the  `-t usb` option to verify your connection info:

```
$ artoo connect scan -t usb
```

Now use the `ID` info returned to find the `product` and `vendor` ID's required to establish a connection with the Digispark in your Artoo code.

That is it, you are set to start running Artoo digispark examples.

### Ubuntu

The main steps are:
- Install the artoo-digispark gem
- Add a udev rule to allow access to the Digispark device (Do not worry
  about this, the `cylon littlewire upload` command does it for you if none is detected)
- Plug in the Digispark to the USB port
- Connect to the device via Artoo

DO NOT plug in the Digispark to your computer's USB port until prompted.

Install the artoo-digispark gem:

```
$ gem install artoo-digispark
```

After installing the artoo-digispark gem run the following command to upload littlewire to the digispark, plug it to a USB port when prompted, you might be asked to enter your sudo password, since uploading littlewire to the digispark requires some new udev rules, you can check and review them in /etc/udev/rules.d/49-micronucleus.rules after running the `artoo littlewire upload` command):

```
$ artoo littlewire upload
```

Once plugged in, use the `artoo connect scan` command with the  `-t usb` option to verify your connection info:

```
$ artoo connect scan -t usb
```

Now use the `ID` info returned to find the `product` and `vendor` ID's required to establish a connection with the Digispark in your Artoo code.

That is it, you are set to start running Artoo digispark examples.

Thanks to [@bluebie](https://github.com/Bluebie) for the help with udev rules used when uploading littlewire to the digispark! (https://github.com/Bluebie/micronucleus-t85/wiki/Ubuntu-Linux)

### Windows

We are currently working with the Celluloid team to add Windows support. Please check back soon!

## Documentation

Check out our [documentation](http://artoo.io/documentation/) for lots of information about how to use Artoo.

## IRC

Need more help? Just want to say "Hello"? Come visit us on IRC freenode #artoo

## Contributing

* All patches must be provided under the Apache 2.0 License
* Please use the -s option in git to "sign off" that the commit is your work and you are providing it under the Apache 2.0 License
* Submit a Github Pull Request to the appropriate branch and ideally discuss the changes with us in IRC.
* We will look at the patch, test it out, and give you feedback.
* Avoid doing minor whitespace changes, renamings, etc. along with merged content. These will be done by the maintainers from time to time but they can complicate merges and should be done seperately.
* Take care to maintain the existing coding style.
* Add unit tests for any new or changed functionality.
* All pull requests should be "fast forward"
  * If there are commits after yours use “git rebase -i <new_head_branch>”
  * If you have local changes you may need to use “git stash”
  * For git help see [progit](http://git-scm.com/book) which is an awesome (and free) book on git


(c) 2012-2014 The Hybrid Group
