#!/bin/sh

# A dwm_bar function that displays the current keyboard layout
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-setxkbmap

dwm_keyboard () {
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "[⌨ %s]\n" "$(setxkbmap -query | awk '/layout/{print $2}')"
    else
        printf "[KEY %s]\n" "$(setxkbmap -query | awk '/layout/{print $2}')"
    fi
}

dwm_keyboard
