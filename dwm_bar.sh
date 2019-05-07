#!/bin/sh

# A modular status bar for dwm
# Joe Standring <joe@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is reccomended that you place functions in the subdirectory ./functions and use: . "$DIR/modules/dwm_example.sh"

# Store the directory the script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Import the modules
. "$DIR/functions/dwm_countdown.sh"
. "$DIR/functions/dwm_cmus.sh"
. "$DIR/functions/dwm_resources.sh"
. "$DIR/functions/dwm_mail.sh"
. "$DIR/functions/dwm_alsa.sh"
. "$DIR/functions/dwm_weather.sh"
. "$DIR/functions/dwm_keyboard.sh"
. "$DIR/functions/dwm_date.sh"

# Update dwm's status bar every second
while true
do
    xsetroot -name "$(dwm_countdown)$(dwm_cmus)$(dwm_resources)$(dwm_mail)$(dwm_alsa)$(dwm_weather)$(dwm_keyboard)$(dwm_date)"
    sleep 1
done
