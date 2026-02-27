#!/bin/sh

Xorg :0 &
export DISPLAY=:0
matchbox-session