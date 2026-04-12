#!/bin/bash -e

apt-get update
apt-get upgrade -y

# Install xorg dependencies
apt-get install -y --no-install-recommends \
    xserver-xorg-core \
    xserver-xorg \
    xinit \
    x11-xserver-utils \
    xauth \
    xfonts-base \
    xserver-xorg-video-fbdev \
    xserver-xorg-input-evdev \
    libx11-6 \
    libx11-dev \
    libxext6 \
    libxrandr2 \
    libxinerama1 \
    libxcursor1 \
    libxi6 \
    libxrender1 \
    libxfixes3 \
    libxdamage1 \
    libxcomposite1 \
    libgl1 \
    libegl1 \
    libxkbcommon-x11-0 \
    openbox \
    libasound2-dev # required for alsa crate

# Install Build dependencies
apt-get install rustup git -y --no-install-recommends


# Set root password
echo "root:root" | chpasswd


# Install cargo
rustup default stable

# Build the dashboard
git clone https://github.com/alexjonker/dash
cd dash
cargo build --release
mv ./target/release/dash /usr/local/bin/dash
cd ..
rm -fr dash

# Create music folder
mkdir -p /storage/music

# Clean up image 
apt-get purge rustup git -y
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf ~/.cargo
rm -fr ~/.rustup
rm -rf /tmp/*