#!/bin/bash
set -e

cd buildroot
git clean -fdX

make raspberrypi2_defconfig
cat ../config-overrides/rpi2 >> .config
make olddefconfig

make -j$(($(nproc) - 2))
