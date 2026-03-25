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

### Option 2: build it yourself
1. Clone this repo with
```bash
git clone https://github.com/AlexJonker/miata-dash
cd miata-dash
```
2. Compile the program and build the image for your device with
```bash
./build.sh
```

3. Flash the file with raspberry pi imager or with
```bash
./flash.sh
```
## Information
The default password and username is both `car`
<!--The desktop is running weston with the rust-based shell. -->