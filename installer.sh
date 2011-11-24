#!/bin/bash

#Running this installer will result in a modded version of avrdude such that your arduino bitbang programmer will work!

sudo apt-get install patch build-essential libreadline-dev libncurses-dev libusb-dev libftdi-dev automake autoconf bison flex
sudo apt-get build-dep avrdude avrdude-doc

# For 64-bit:
#wget http://www.ftdichip.com/Drivers/D2XX/Linux/libftd2xx0.4.16_x86_64.tar.gz
# For 32-bit:
wget http://www.ftdichip.com/Drivers/D2XX/Linux/libftd2xx0.4.16.tar.gz

tar xzf avrdude-5.10.tar.gz
tar xzf libftd2xx*.tar.gz
cd avrdude-5.10
for file in ../patch-*.diff; do patch -p0 < $file; done
cp ../libftd2xx*/static_lib/* .
cp ../libftd2xx*/*.h .
cp ../libftd2xx*/*.cfg .
./configure CFLAGS="-g -O2 -DSUPPORT_FT245R" LIBS="./libftd2xx.a.0.4.16 -lpthread -ldl -lrt"
make

echo '
programmer
  id    = "ftdi";
  desc  = "SparkFun FTDI Basic Breakout";
  type  = ft245r;
  miso  = 1;  # RXD          
  sck   = 3;  # CTS
  mosi  = 0;  # TXD
  reset = 4;  # DTR              
;

programmer
  id    = "arduino";
  desc  = "Arduino board configuration";
  type  = ft245r;
  miso  = 3;  # RXD          
  sck   = 5;  # CTS
  mosi  = 6;  # TXD
  reset = 7;  # DTR              
;' >> avrdude.conf;

wdir=pwd

echo "
alias arduinodude='sudo $wdir/avrdude -C $wdir/avrdude.conf -c arduino -P ft0'" >> ~/.bashrc


