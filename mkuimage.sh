#!/bin/sh
cd $(dirname $0)
output/host/usr/bin/mkimage -A arm -O linux -C none -T kernel -a 0x80008000 -e 0x80008000 -n Linux-3.8.13 -d output/build/linux-ddd36e546e53d3c493075bbebd6188ee843208f9/arch/arm/boot/Image output/images/uImage
