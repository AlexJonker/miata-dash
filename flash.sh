#!/bin/bash
set -e

IMAGE_PATH="./output/image.img"

if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: Image file not found, did you run build.sh?"
    exit 1
fi

echo "Available drives:"
echo "=================="
lsblk -d -o NAME,SIZE,TYPE | grep disk
echo ""

read -p "Enter drive to flash (e.g., sda, sdb): " drive

if [ -z "$drive" ]; then
    echo "Error: No drive specified"
    exit 1
fi

drive_path="/dev/$drive"

if [ ! -b "$drive_path" ]; then
    echo "Error: Drive $drive_path not found"
    exit 1
fi

echo "WARNING: This will erase all data on $drive_path"
read -p "Are you sure? Type 'yes' to confirm: " confirm

if [ "$confirm" != "yes" ]; then
    echo "Cancelled"
    exit 0
fi

echo "Flashing $IMAGE_PATH to $drive_path..."
sudo dd if="$IMAGE_PATH" of="$drive_path" bs=4M status=progress
sudo sync
sudo eject "$drive_path"

echo "Flashing complete!"