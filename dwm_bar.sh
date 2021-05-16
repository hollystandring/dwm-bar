#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is recommended that you place functions in the subdirectory ./bar-functions and use: . "$DIR/bar-functions/dwm_example.sh"

# Store the directory the script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Change the appearance of the module identifier. if this is set to "unicode", then symbols will be used as identifiers instead of text. E.g. [📪 0] instead of [MAIL 0].
# Requires a font with adequate unicode character support
export IDENTIFIER="unicode"

# Change the charachter(s) used to seperate modules. If two are used, they will be placed at the start and end.
export SEP1="["
export SEP2="]"

# Import the modules
. "$DIR/bar-functions/dwm_countdown.sh"
. "$DIR/bar-functions/dwm_alarm.sh"
. "$DIR/bar-functions/dwm_transmission.sh"
. "$DIR/bar-functions/dwm_cmus.sh"
. "$DIR/bar-functions/dwm_mpc.sh"
. "$DIR/bar-functions/dwm_spotify.sh"
. "$DIR/bar-functions/dwm_resources.sh"
. "$DIR/bar-functions/dwm_battery.sh"
. "$DIR/bar-functions/dwm_mail.sh"
. "$DIR/bar-functions/dwm_backlight.sh"
. "$DIR/bar-functions/dwm_alsa.sh"
. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_weather.sh"
. "$DIR/bar-functions/dwm_vpn.sh"
. "$DIR/bar-functions/dwm_networkmanager.sh"
. "$DIR/bar-functions/dwm_keyboard.sh"
. "$DIR/bar-functions/dwm_ccurse.sh"
. "$DIR/bar-functions/dwm_date.sh"
. "$DIR/bar-functions/dwm_connman.sh"
. "$DIR/bar-functions/dwm_loadavg.sh"
. "$DIR/bar-functions/dwm_currency.sh"

parallelize() {
    while true
    do
        printf "Running parallel processes\n"
        dwm_weather &
        dwm_networkmanager &
        sleep 5
    done
}
parallelize &

# Update dwm status bar every second
while true
do
    # Append results of each func one by one to the upperbar string
    upperbar=""
    upperbar="$upperbar$(dwm_connman)"
    upperbar="$upperbar$(dwm_countdown)"
    upperbar="$upperbar$(dwm_alarm)"
    upperbar="$upperbar$(dwm_transmission)"
    upperbar="$upperbar$(dwm_cmus)"
    upperbar="$upperbar$(dwm_mpc)"
    upperbar="$upperbar$(dwm_spotify)"
    upperbar="$upperbar$(dwm_resources)"
    upperbar="$upperbar$(dwm_battery)"
    upperbar="$upperbar$(dwm_mail)"
    upperbar="$upperbar$(dwm_backlight)"
    upperbar="$upperbar$(dwm_alsa)"
    upperbar="$upperbar$(dwm_pulse)"
    upperbar="$upperbar${__DWM_BAR_WEATHER__}"
    upperbar="$upperbar$(dwm_vpn)"
    upperbar="$upperbar${__DWM_BAR_NETWORKMANAGER__}"
    upperbar="$upperbar$(dwm_keyboard)"
    upperbar="$upperbar$(dwm_ccurse)"
    upperbar="$upperbar$(dwm_date)"
    upperbar="$upperbar$(dwm_loadavg)"
    upperbar="$upperbar$(dwm_currency)"
   
    # Append results of each func one by one to the lowerbar string
    lowerbar=""

    
    xsetroot -name "$upperbar"
    
    # Uncomment the line below to enable the lowerbar 
#    xsetroot -name "$upperbar;$lowerbar"
    sleep 1
done
