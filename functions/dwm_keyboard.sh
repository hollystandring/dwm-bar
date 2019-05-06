#!/bin/sh

# A dwm_bar function that displays the current keyboard layout
# Joe Standring <jstandring@pm.me>
# GNU GPLv3

# Dependencies: xorg-setxkbmap

dwm_keyboard () {
    printf "[\U2328 $(setxkbmap -query | awk '/layout/{print $2}')]\n"
}
dwm_keyboard
