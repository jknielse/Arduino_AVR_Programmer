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

cp ../libftd2xx1.0.4/ftd2xx.h ./
cp ../libftd2xx1.0.4/WinTypes.h ./
cp ../libftd2xx1.0.4/build/i386/libftd2xx.a ./

./configure

rm Makefile
mv ../Makefile ./

make

