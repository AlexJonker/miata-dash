#!/bin/bash

qemu-system-arm \
        -M raspi2b \
        -m 1024 \
        -kernel modules/buildroot/output/images/zImage \
        -dtb modules/buildroot/output/images/bcm2709-rpi-2-b.dtb \
        -drive file=modules/buildroot/output/images/rootfs.ext2,if=sd,format=raw \
        -append "root=/dev/mmcblk0 rootwait console=ttyAMA0,115200" \
        -serial stdio \
        -display none