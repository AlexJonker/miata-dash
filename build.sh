#!/bin/bash
set -e

if [ -d "output" ]; then
    echo "Removing old output directory..."
    sudo rm -rf output
fi

echo "Building the image using act..."
act -W .github/workflows/release.yml --container-options "--privileged -v /dev:/dev -v $(pwd):/workspace" -j build


echo "Build complete! The image is located at ./output/image.img"


echo ""
echo "================================"
echo ""

echo "Do you want to flash the image now? (y/n)"
read -r answer
if [[ "$answer" == "y" ]]; then
    echo "Flashing image to SD card..."
    ./flash.sh
else
    echo "You can flash the image later by running ./flash.sh"
fi