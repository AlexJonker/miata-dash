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

### Option 1: download and flash (recommended )
1. Download the latest image from [the release page](https://github.com/AlexJonker/car-thing/releases/latest)
2. Unzip the downloaded zip file
3. Flash the unzipped file with raspberry pi imager.

### Option 2: compile and flash (linux)
1. Clone this repo with
```bash
git clone https://github.com/AlexJonker/car-thing
cd car-thing
```
2. Update submodules with
```bash
git submodule update --init
```
3. Compile the program and build the image with
```bash
./build.sh
```
4. Flash the file with raspberry pi imager or with
```bash
./flash.sh
```