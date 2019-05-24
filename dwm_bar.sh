#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is recommended that you place functions in the subdirectory ./functions and use: . "$DIR/modules/dwm_example.sh"

# Store the directory the script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Change the appearance of the module identifier. if this is set to "unicode", then symbols will be used as identifiers instead of text. E.g. [📪 0] instead of [MAIL 0].
# Requires a font with adequate unicode character support
#export IDENTIFIER="unicode"

# Import the modules
. "$DIR/functions/dwm_countdown.sh"
. "$DIR/functions/dwm_cmus.sh"
. "$DIR/functions/dwm_resources.sh"
. "$DIR/functions/dwm_mail.sh"
. "$DIR/functions/dwm_alsa.sh"
# . "$DIR/functions/dwm_pulse.sh"
. "$DIR/functions/dwm_weather.sh"
. "$DIR/functions/dwm_keyboard.sh"
. "$DIR/functions/dwm_date.sh"

# Update dwm status bar every second
while true
do
    xsetroot -name "$(dwm_countdown)$(dwm_cmus)$(dwm_resources)$(dwm_mail)$(dwm_alsa)$(dwm_weather)$(dwm_keyboard)$(dwm_date)"
    sleep 1
done
