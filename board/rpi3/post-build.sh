#!/usr/bin/env bash
set -e

TARGET_DIR="$1"

# Ensure /root exists
mkdir -p "${TARGET_DIR}/root"

# Copy everything from src/home into /root
rsync -a --delete "${BR2_EXTERNAL:-.}/../src/home/" "${TARGET_DIR}/root/"
