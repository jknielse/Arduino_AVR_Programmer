#!/bin/bash

#Run this script to install the special version of avrdude for your modded arduino AVR programmer.

for arch in *.tar.gz
do
    tar -xzf $arch
    rm $arch
done

cd avrdude-5.3.1

patch <../serjtag-0.3/avrdude-serjtag/src/avrdude-5.3.1-usb910.patch
patch <../serjtag-0.3/avrdude-serjtag/src/avrdude-5.3.1-avr910d.patch
patch <../serjtag-0.3/avrdude-serjtag/src/avrdude-5.3.1-serjtag.patch
patch <../serjtag-0.3/avrdude-serjtag/src/avrdude-5.3.1-ft245r.patch
patch <../serjtag-0.3/avrdude-serjtag/src/avrdude-5.3.1-baud.patch

cp ../libftd2xx0.4.16/ftd2xx.h ./
cp ../libftd2xx0.4.16/WinTypes.h ./
cp ../libftd2xx0.4.16/static_lib/libftd2xx.a.0.4.16 ./

mv ../Makefile ./

mv ../config.status ./

./configure

make

cp ../serjtag-0.3/avrdude-serjtag/binary/avrdude.conf ./

cd /usr/lib
sudo cp ~/installs/libftd2xx0.4.16_x86_64/libftd2xx.so.0.4.16 ./
sudo ln -s libftd2xx.so.0.4.16 libftd2xx.so
sudo ln -s libftd2xx.so.0.4.16 libftd2xx.so.0
