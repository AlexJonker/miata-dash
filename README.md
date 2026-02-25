<p align="center">
  <!-- <img src="./assets/icon.png" alt="logo" width="150" /> -->
  <br>
  <strong>Miata Dash</strong>
  <br><br>
  A full linux based headunit system for in my miata.
  <br>
  I am running this on a pi3 with a 7 inch touchscreen.
</p>



## Installation

### Option 1: download and flash (recommended)
1. Download the latest image from [the release page](https://github.com/AlexJonker/miata-dash/releases/latest)
2. Flash the downloaded file with raspberry pi imager.

### Option 2: compile and flash (linux)
1. Clone this repo with
```bash
git clone https://github.com/AlexJonker/miata-dash
cd miata-dash
```
2. Update submodules with
```bash
git submodule update --init --recursive
```
3. Compile the program and build the image for your device with
```bash
./build.sh rpi3
```
Use `rpi2` if you are building for a Raspberry Pi 2.

4. Flash the file with raspberry pi imager or with
```bash
./flash.sh
```