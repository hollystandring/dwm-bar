#!/bin/sh

# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: alsa-utils

dwm_alsa () {
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$VOL" -eq 0 ]; then
            printf "[🔇 %s]\n" "$VOL]\n"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "[🔈 %s]\n" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "[🔉 %s]\n" "$VOL"
        else
            printf "[🔊 %s]\n" "$VOL"
        fi
    else
        if [ "$VOL" -eq 0 ]; then
            printf "[VOL %s]\n" "$VOL]\n"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
            printf "[VOL %s]\n" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
            printf "[VOL %s]\n" "$VOL"
        else
            printf "[VOL %s]\n" "$VOL"
        fi
    fi
}

dwm_alsa
