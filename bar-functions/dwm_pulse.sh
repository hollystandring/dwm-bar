#!/bin/sh

# A dwm_bar function to show the master volume of PulseAudio
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: pamixer

dwm_pulse () {
    VOL=$(pamixer --get-volume)
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

dwm_pulse
