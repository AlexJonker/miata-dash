#!/bin/bash
set -e

TARGET_DEVICE="${1:-rpi3}"

case "$TARGET_DEVICE" in
    rpi2)
        DEFCONFIG="raspberrypi2_defconfig"
        ;;
    rpi3)
        DEFCONFIG="raspberrypi3_defconfig"
        ;;
    rpi4)
        DEFCONFIG="raspberrypi4_defconfig"
        ;;
    *)
        echo "Error: Unsupported target '$TARGET_DEVICE'. Use 'rpi2', 'rpi3', or 'rpi4'."
        echo "Usage: ./build.sh [rpi2|rpi3|rpi4]"
        exit 1
        ;;
esac

cd modules/buildroot

echo "Configuring Buildroot for ${TARGET_DEVICE}"
make "$DEFCONFIG"
cat "../../config-overrides/defconfig" >> .config
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
    cd ../..
    echo "Flashing image to SD card..."
    ./flash.sh
else
    echo "You can flash the image later by running ./flash.sh"
fi