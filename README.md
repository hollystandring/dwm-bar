# dwm-bar
A modular statusbar for DWM
![screenshot](dwm-bar.png)
## Table of Contents
- [Current Functions](#current-functions)
  - [dwm_alsa](#dwm_alsa)
  - [dwm_countdown](#dwm_countdown)
  - [dwm_keyboard](#dwm_keyboard)
  - [dwm_resources](#dwm_resources)
  - [dwm_cmus](#dwm_cmus)
  - [dwm_date](#dwm_date)
  - [dwm_mail](#dwm_mail)
  - [dwm_weather](#dwm_weather)
- [Installation](#installation)
- [Usage](#usage)
- [Customizing](#customizing)
- [Acknowledgements](#acknowledgements)
- [More to come!](#more-to-come)
## Current Functions
### dwm_alsa
Displays the current master volume of ALSA
```
[🔉 55]
```
Dependencies: ```alsa-utils```
### dwm_countdown
Displays the status of [countdown](https://github.com/joestandring/countdown)
```
[⏳ 00:10:00]
```
Dependeincies: ```[countdown](https://github.com/joestandring/countdown)```
### dwm_keyboard
Displays the current keyboard layout
```
[⌨ gb]
```
Dependencies: ```xorg-setxkbmap```
### dwm_resources
Displays information regarding memory, CPU temperature, and storage
```
[🖥 MEM 1.3Gi/15Gi CPU 45C STO 2.3G/200G: 2%]
```
### dwm_cmus
displays current cmus status, artist, track, position, duration, and shuffle
```
[▶ The Unicorns - Tuff Ghost 0:43/2:56 🔀]
```
Dependencies: ```cmus```
### dwm_date
Displays the current date and time
```
[🕰 Mon 06-05-19 21:31:58]
```
### dwm_mail
Displays the current number of emails in an inbox
```
[📫 2]
```
### dwm_weather
Displays the current weather provided by [wttr.in](https://wttr.in)
```
[☀ +20°C]
```
## Installation
1. Clone and enter the repository:
```
$ git clone https://github.com/joestandring/dwm-bar
$ cd dwm-bar
```
2. Make the script executable
```
$ chmod +x dwm_bar.sh
```
## Usage
Simply run the script and dwm should display your bar:
```
$ ./dwm_bar.sh
```
If you would like your bar to be displayed when X starts, add this to your .xinitrc file before launching dwm. For example, if the script is located in /home/$USER/dwm-bar/:
```
# Statusbar
/home/$USER/dwm-bar/dwm_status.sh &

# Start dwm
exec dwm
```
## Customizing
dwm-bar is completley modular, meaning you can mix and match functions to your hearts content. It's functions are located in the functions/ subdirectory and included in dwm_bar.sh
If you want to make your own function, for example dwm_myfunction.sh, you should create it in the functions/ subdirectory before including it in dwm_bar.sh and adding it to the xsetroot command:
```
# Import the modules
. "$DIR/functions/dwm_myfucntion"

while true
do
    xsetroot -name "$(dwm_myfunction)"
    sleep 1
done
```
## Acknowledgements
Code for some functions was modified from:
* [Klemens Nanni](https://notabug.org/kl3)
* [@boylemic](https://github.com/boylemic/configs/blob/master/dwm_status)
* [Parket Johnson](https://github.com/ronno/scripts/blob/master/xsetcmus)
* [suckless.org](https://dwm.suckless.org/status_monitor/)
## More to come!
* Ability to choose between showing unicode charachters or plaintext for identifiers in the bar
* dwm_pulse function to control pulseaudio sound
* dwm_bat function to display battery percentage and status
* dwm_notifs function to show the last recieved notification in the bar
* The ability to show network speeds and SSID in dwm_network
