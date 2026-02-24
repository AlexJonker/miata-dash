#!/bin/bash
set -e

cd modules/buildroot

echo "Configuring Buildroot for Raspberry Pi 2"
make raspberrypi2_defconfig
cat ../config-overrides/rpi2 >> .config
make olddefconfig

echo "Building image (this may take a while)"
make -j$(nproc)

echo "Build complete! The image is located at modules/buildroot/output/images/sdcard.img"


echo ""
echo "================================"
echo ""

echo "Do you want to flash the image to an SD card now? (y/n)"
read -r answer
if [[ "$answer" == "y" ]]; then
    cd ..
    echo "Flashing image to SD card..."
    ./flash.sh
else
    echo "You can flash the image later by running ./flash.sh"
fi