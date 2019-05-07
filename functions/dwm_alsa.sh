#!/bin/sh

# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: alsa-utils

dwm_alsa () {
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    if [ $VOL -eq 0 ]; then
        printf "[\U1F507 $VOL]\n"
    elif [ $VOL -gt 0 ] && [ $VOL -le 33 ]; then
        printf "[\U1F508 $VOL]\n"
    elif [ $VOL -gt 33 ] && [ $VOL -le 66 ]; then
        printf "[\U1F509 $VOL]\n"
    else
        printf "[\U1F50A $VOL]\n"
    fi
}
dwm_alsa
