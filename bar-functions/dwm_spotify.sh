#!/bin/sh

# A dwm_bar function that shows the current artist, track, duration, and status from Spotify using playerctl
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: spotify, playerctl

# TODO: Find a method to get track position data and shuffle status (currently playerctl does not work for this)

dwm_spotify () {
    if ps -C spotify > /dev/null; then
        ARTIST=$(playerctl -p spotify metadata artist)
        TRACK=$(playerctl -p spotify metadata title)
        DURATION=$(playerctl -p spotify metadata mpris:length | sed 's/.\{6\}$//')
        STATUS=$(playerctl -p spotify status)

        if [ "$IDENTIFIER" = "unicode" ]; then
            if [ "$STATUS" = "Playing" ]; then
                STATUS="▶"
            else
                STATUS="⏸"
            fi
        else
            if [ "$STATUS" = "Playing" ]; then
                STATUS="PLA"
            else
                STATUS="PAU"
            fi
        fi
        
        printf "%s%s %s - %s " "$SEP1" "$STATUS" "$ARTIST" "$TRACK"
        printf "%0d:%02d" $((DURATION%3600/60)) $((DURATION%60))
        printf "%s\n" "$SEP2"
    fi
}

dwm_spotify
