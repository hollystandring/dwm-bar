#!/bin/sh

# A dwm_bar module to display the current backlight brighness with xbacklight
# GNU GPLv3

# Dependencies: xbacklight

dwm_backlight () {
    printf "%s☀ %.0f%s\n" "$SEP1" "$(xbacklight)" "$SEP2"
}

dwm_backlight
