#!/bin/sh

# A dwm_bar function to show the closest appointment in calcurse
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: calcurse

dwm_ccurse () {
    APPOINTMENT=$(calcurse -a | head -n 3 | tr -d '\n+>-' | awk '$1=$1' | sed 's/://')

    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "[💡 %s]\n" "$APPOINTMENT"
    else
        printf "[APT %s]\n" "$APPOINTMENT"
    fi
}

dwm_ccurse
