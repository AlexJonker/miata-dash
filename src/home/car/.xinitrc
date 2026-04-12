#!/bin/sh

# Disable screen sleep and suspend
xset s off
xset s noblank
xset -dpms

openbox &
exec /usr/local/bin/dash
