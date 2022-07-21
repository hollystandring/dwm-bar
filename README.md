# dwm-bar
A modular statusbar for dwm
![screenshot](https://raw.githubusercontent.com/joestandring/dwm-bar/master/sshot.png)
## Table of Contents
- [Installation](#installation)
- [Configuration](#configuration)
  - [Enabling Functions](#enabling-functions)
  - [Refresh Rate](#refresh-rate)
  - [Configuring Functions](#configuring-functions)
  - [Identifiers](#identifiers)
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
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
> :warning: While I try to be as active as I can be, it may take me some time to resolve issues as I am much busier these days than when I started this project. I appreciate ALL contributions and will try my best to respond as soon as I am able to. Thank you for understanding :) - @joestandring
## Installation
1. Clone and enter the repository:
```
git clone https://github.com/joestandring/dwm-bar
cd dwm-bar
```
2. (Optional) Install Dependencies from ```dep/YourDisto.txt```. This will install dependencies for ALL functions so consider excluding ones you do not plan to use. These can be found at the top of each bar function.
```
sudo xbps-install -S $(cat dep/void.txt) # Void
sudo pacman -S $(cat dep/arch.txt)       # Arch
sudo dnf install $(cat dep/fedora.txt)   # Fedora
```
> :warning: There are no dnf packages for [spotifyd](https://github.com/Spotifyd/spotifyd), [pamixer](https://github.com/cdemoulins/pamixer) and [cmus](https://github.com/cmus/cmus). If you want to utilise these packages, please install them manually as shown in the corresponding gihub repos.
3. (Optional) If you plan to use unicode identifiers, you should install a font which includes these ([Nerd Fonts](https://github.com/ryanoasis/nerd-fonts), [siji](https://github.com/stark/siji))
4. Enable/disable desired functions (see [Configuration](#configuration)).
5. Run the script
```
./dwm_bar.sh
```

## Configuration
dwm-bar will require some setup before it can be used.
### Enabling Functions
Functions can be enabled by adding them to the import and upperbar variable in dwm_bar.sh. By default, all available functions will be commented here. If you are using the [extrabar](https://dwm.suckless.org/patches/extrabar/) patch, functions can also be added to lowerbar to appear on the bottom of the screen. Some more intensive functions are parallelized to prevent the bar freezing. These are imported the same as regular functions but added to the ```parallelize()``` function first. These use different names to regular functions and are commented out by default in dwm_bar.sh.

To enable dwm_battery and dwm_backlight on the top bar and dwm_pulse and dwm_weather (parallelized) on the bottom bar, for example, you should use:
```
# Import the modules
. "$DIR/bar-functions/dwm_battery.sh"
. "$DIR/bar-functions/dwm_backlight.sh"
. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_weather.sh"

parallelize() {
    while true
    do
        printf "Running parallel processes\n"
        dwm_weather &
        sleep 5
    done
}
parallelize &

# Update dwm status bar every second
while true
do
    # Append results of each func one by one to the upperbar string
    upperbar=""
    upperbar="$upperbar$(dwm_battery)"
    upperbar="$upperbar$(dwm_backlight)"
   
    # Append results of each func one by one to the lowerbar string
    lowerbar=""
    lowerbar="$lowerbar$(dwm_pulse)"
    lowerbar="$lowerbar$(__DWM_BAR_WEATHER__)"
    
    #xsetroot -name "$upperbar"
    
    # Uncomment the line below to enable the lowerbar 
    xsetroot -name "$upperbar;$lowerbar"
    sleep 1
done
```
### Refresh rate
If updating the bar every second is an issue, you can change the ```sleep``` amount of both regular and parallelized functions in dwm_bar.sh.
### Configuring functions
Some functions, such as dwm_weather require additional setup and will be outlined with a comment where this is the case.
### Identifiers
Unicode or plaintext identifiers can be used by altering the ```$IDENTIFIER``` value in dwm_bar.sh. For example, when set to ```"unicode"```, dwm_mail will display:
```
[📫 0]
```
Otherwise, when not set it will display:
```
[MAIL 0]
```
## Current Functions
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
## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md) before contributing.
## Acknowledgements
Code for some functions was modified from:
* [Klemens Nanni](https://notabug.org/kl3)
* [@boylemic](https://github.com/boylemic/configs/blob/master/dwm_status)
* [Parket Johnson](https://github.com/ronno/scripts/blob/master/xsetcmus)
* [suckless.org](https://dwm.suckless.org/status_monitor/)
* [@mcallistertyler95](https://github.com/mcallistertyler95/dwm-bar)
