#!/usr/bin/env bash
set -e

TARGET_DIR="$1"

# Ensure /root exists
mkdir -p "${TARGET_DIR}/root"

# Copy everything from src/home into /root
rsync -a --delete "${BR2_EXTERNAL:-.}/../src/home/" "${TARGET_DIR}/root/"

# Create a regular user 'car' (UID/GID 1000) if it doesn't already exist,
# create its home directory and enable autologin on tty1.
if ! grep -q "^car:" "${TARGET_DIR}/etc/passwd" 2>/dev/null; then
	echo "car:x:1000:1000:Car User:/home/car:/bin/sh" >> "${TARGET_DIR}/etc/passwd"
fi

if ! grep -q "^car:" "${TARGET_DIR}/etc/group" 2>/dev/null; then
	echo "car:x:1000:" >> "${TARGET_DIR}/etc/group"
fi

# Ensure home exists and copy any repo-provided home files into it
mkdir -p "${TARGET_DIR}/home/car"
if [ -d "${BR2_EXTERNAL:-.}/../src/home" ]; then
	rsync -a --delete "${BR2_EXTERNAL:-.}/../src/home/" "${TARGET_DIR}/home/car/" || true
fi
chown -R 1000:1000 "${TARGET_DIR}/home/car" || true

# Configure autologin on tty1 by adding a login -f line to /etc/inittab
if [ -f "${TARGET_DIR}/etc/inittab" ]; then
	# Remove existing tty1 lines to avoid duplicates
	sed -i '/tty1/Id' "${TARGET_DIR}/etc/inittab" || true
	cat >> "${TARGET_DIR}/etc/inittab" <<'EOF'
# Auto-login on tty1 as user car
tty1::respawn:/bin/login -f car </dev/tty1 >/dev/tty1 2>&1
EOF
fi
