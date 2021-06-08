# dwm-bar
A modular statusbar for dwm
![screenshot](sshot.png)
[![ko-fi](https://www.ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/J3J11S7DZ)
## Table of Contents
- [Current Functions](#current-functions)
  - [dwm_alsa](#dwm_alsa)
  - [dwm_pulse](#dwm_pulse)
  - [dwm_battery](#dwm_battery)
  - [dwm_countdown](#dwm_countdown)
  - [dwm_alarm](#dwm_alarm)
  - [dwm_keyboard](#dwm_keyboard)
  - [dwm_resources](#dwm_resources)
  - [dwm_cmus](#dwm_cmus)
  - [dwm_mpc](#dwm_mpc)
  - [dwm_spotify](#dwm_mpc)
  - [dwm_date](#dwm_date)
  - [dwm_mail](#dwm_mail)
  - [dwm_weather](#dwm_weather)
  - [dwm_networkmanager](#dwm_networkmanager)
  - [dwm_wpa](#dwm_wpa)
  - [dwm_vpn](#dwm_vpn)
  - [dwm_ccurse](#dwm_ccurse)
  - [dwm_transmission](#dwm_transmission)
  - [dwm_backlight](#dwm_backlight)
  - [dwm_connman](#dwm_connman)
  - [dwm_loadavg](#dwm_loadavg)
  - [dwm_currency](#dwm_currency)
  - [dwm_solar_panel](#dwm_solar_panel)
- [Installation](#installation)
- [Configuration](#configuration)
- [Reccomendations](#reccomendations)
- [Usage](#usage)
- [Customizing](#customizing)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
### dwm_alsa
Displays the current master volume of ALSA
```
[🔉 55%]
```
Dependencies: ```alsa-utils```
### dwm_pulse
Displays the current master volume of PulseAudio
```
[🔉 55%]
```
Dependencies: ```pamixer```
### dwm_battery
Displays battery level and status
```
[🔋 100% full]
```
### dwm_countdown
Displays the status of [countdown](https://github.com/joestandring/countdown)
```
[⏳ 00:10:00]
```
Dependencies: ```countdown.sh```
### dwm_alarm
Displays upcoming alarms from [alarm](https://github.com/joestandring/alarm)
```
[⏰ 22:30:00]
```
Dependencies: ```alarm.sh```
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
Displays current cmus status, artist, track, position, duration, and shuffle
```
[▶ The Unicorns - Tuff Ghost 0:43/2:56 🔀]
```
Dependencies: ```cmus```
### dwm_mpc
Displays current mpc status, artist, track, position, duration, and shuffle
```
[▶ The Unicorns - Tuff Ghost 0:43/2:56 🔀]
```
Dependencies: ```mpc```
### dwm_spotify
Displays current Spotify status, artist, track, and duration

Either the official Spotify client or spotifyd can be used. Unfortunately, only spotifyd can provide track position and shuffle status
```
[▶ The Unicorns - Tuff Ghost 0:43/2:56 🔀]
```
Dependencies: ```spotify/spotifyd, playerctl```

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

Please remember wttr.in has a limited number of requests, so this module may occasionally not be able to recieve weather information when experiencing high traffic.
```
[☀ +20°C]
```
### dwm_networkmanager
Displays the current network connection, private IP, and public IP using NetworkManager
```
[🌐 enp7s0: 192.168.0.1/24 | 185.199.109.153]
```
Dependencies: ```NetworkManager, curl```
### dwm_wpa
Displays the current network connection and private IP using wpa_cli
```
[襤 My-Wifi 192.168.0.3]
```
Dependencies: ```wpa_cli```
### dwm_vpn
Displays the current VPN connections with OpenVPN or Wireguard
```
[🔒 Sweden - Stockholm]
```
Dependencies: ```NetworkManager, NetworkManager-openvpn (for OpenVPN connections)```
### dwm_ccurse
Displays the next appointment from calcurse
```
[💡 18/04/19 19:00 20:00 Upload dwm_ccurse]
```
Dependencies: ```calcurse```
### dwm_transmission
Displays the current status of a torrent with transmission-remote
```
[⏬ archlinux-2019.06.01... | 92% 1min ⬆3.4 ⬇1.5]
```
Dependencies: ```transmission-remote```
### dwm_backlight
Displays the current backlight level with xbacklight
```
[☀ 80]
```
Dependencies: ```xbacklight```
### dwm_connman
Shows network information IP, SSID, WLan strength (if connected to WLan) using connman.
```
[🌐 192.169.189.12 HomeNetworkName 53%]
```
Dependencies: ```connman```
### dwm_loadavg
Displays the average system load
```
[⏱ 0.14 0.17 0.18]
```
### dwm_solar_panel
Displays how much power is being produced from your solar panels
```
[💡 3.012 W ]
```
### dwm_currency
Displays the current rate of your currency in comparison to the USD provided by [rate.sx](http://rate.sx/)
```
[💡 1.225 ]
```
Dependencies: ```curl```

## Installation
1. Clone and enter the repository:
```
$ git clone https://github.com/joestandring/dwm-bar
$ cd dwm-bar
```
2. Install Dependencies from dep/YourDisto.txt

  * For Arch Linux 

```
$ sudo pacman -S $(dep/arch.txt)
```

  * For Fedora Linux

```
$ sudo dnf install $(dep/fedora.txt)
```

> :warning: There are no dnf packages for [spotyfyd](https://github.com/Spotifyd/spotifyd), [pamixer](https://github.com/cdemoulins/pamixer) and [cmus](https://github.com/cmus/cmus). If you want to utilise these packages, please install them manually as shown in the corresponding gihub repos.

3. Make the script executable
```
$ chmod +x dwm_bar.sh
```

## Configuration
dwm-bar supports the [extrabar](https://dwm.suckless.org/patches/status2d/dwm-status2d-extrabar-6.2.diff) patch for dwm. This allows the user to add a second status bar at the bottom of the screen. To add the second bar:

1. Patch dwm with the the [extrabar](https://dwm.suckless.org/patches/status2d/dwm-status2d-extrabar-6.2.diff) plugin
2. Comment out the line ```xsetroot -name "$upperbar"``` in ```dwm_bar.sh```
3. Uncomment the line ```xsetroot -name "$upperbar;$lowerbar"``` in ```dwm_bar.sh```
4. Append functions underneath ```upperbar=""``` and ```lowerbar=""```. For example:
```
# Append results of each func one by one to the upperbar string
upperbar=""
upperbar="$upperbar$(dwm_myupperfunction)"

# Append results of each func one by one to the lowerbar string
lowerbar=""
lowerbar="$lowerbar$(dwm_mylowerfunction)"
```

## Recommendations
To make the most out of Unicode support, consider using a font that includes many Unicode characters. For example:
* [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
* [Siji](https://github.com/stark/siji)
* [Font Awesome](https://fontawesome.com/)

While not always necessary, it's a good idea to specify these fonts in your dwm config.
## Quick Start
Simply run the script and dwm should display your bar:
```
$ ./dwm_bar.sh
```
Most likely, you will need to change some values for functions to get them to work - these are outlined with a comment for functions where this is likely the case.
If you would like your bar to be displayed when X starts, add this to your .xinitrc file before launching dwm. For example, if the script is located in /home/$USER/dwm-bar/:
```
# Statusbar
/home/$USER/dwm-bar/dwm_bar.sh &

# Start dwm
exec dwm
```
## Customizing
dwm-bar is completely modular, meaning you can mix and match functions to your heart's content. It's functions are located in the bar-functions/ subdirectory and included in dwm_bar.sh
If you want to make your own function, for example, dwm_myfunction.sh, you should create it in the bar-functions/ subdirectory before including it in dwm_bar.sh and adding it to the xsetroot command:
```
# Import the modules
. "$DIR/bar-functions/dwm_myfucntion"

while true
do
    xsetroot -name "$(dwm_myfunction)"
    sleep 1
done
```
You can also decide to use Unicode or plaintext identifiers for functions by altering the ```$IDENTIFIER``` value. For example, set to ```"unicode"```, ```dwm_mail``` will display:
```
[📫 0]
```
Whereas, if it is not set it will display:
```
[MAIL 0]
```
## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) before contributing.
## Acknowledgements
Code for some functions was modified from:
* [Klemens Nanni](https://notabug.org/kl3)
* [@boylemic](https://github.com/boylemic/configs/blob/master/dwm_status)
* [Parket Johnson](https://github.com/ronno/scripts/blob/master/xsetcmus)
* [suckless.org](https://dwm.suckless.org/status_monitor/)
* [@mcallistertyler95](https://github.com/mcallistertyler95/dwm-bar)
