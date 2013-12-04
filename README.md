Buildroot SNES9x for BeagleBone
===============================

This fork of Buildroot is specifically targeted at building files that can be used to run 
the SNES9x application for emulating the Super Ninendo Entertainment System on BeagleBone
Black. The output files can be dropped onto a normal FAT-formatted microSD card and will
boot directly into the application.


Notes
-----
* It might be necessary to mark the partition bootable and hold the boot button when
  applying power if the bootloader on your BeagleBone Black isn't compatible with booting
  from the microSD


Build system requirements
-------------------------
* You need to be using a Linux box to build this code
* Check out the Buildroot manual for more details


Building
--------

  git clone git://github.com/jadonk/buildroot && cd buildroot
  git checkout snes9x
  make beaglebone_defconfig
  make


Booting
-------
* Copy MLO, u-boot.img, uEnv.txt, uImage, autorun.sh and games.cfg from the output/images directory
  to a FAT-formatted microSD card
* Copy your SMC ROM files into a rom directory on the microSD card and edit your games.cfg file as
  described in the documentation at http://www.beaglesnes.org
* Insert the card into your powered-off BeagleBone Black that already has the gaming
  controller connected and is connected to your TV via the microHDMI cable
* Hold the boot button and apply power
