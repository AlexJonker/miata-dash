#!/bin/bash
set -e

cd buildroot
echo "Cleaning old configs"
rm -f .config
rm -f .config.old
rm -f ..config.tmp

echo "Configuring Buildroot for Raspberry Pi 2"
make raspberrypi2_defconfig
cat ../config-overrides/rpi2 >> .config
make olddefconfig

echo "Building image (this may take a while)"
make -j$(nproc)

echo "Build complete! The image is located at buildroot/output/images/sdcard.img"