#!/bin/sh

# A dwm_bar function to show the closest appointment in calcurse
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: calcurse

dwm_ccurse () {
    APPOINTMENT=$(calcurse -a | head -n 3 | tr -d '\n+>-' | awk '$1=$1' | sed 's/://')

    if [ "$APPOINTMENT" != "" ]; then
        printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            printf "💡 %s" "$APPOINTMENT"
        else
            printf "APT %s" "$APPOINTMENT"
        fi
        printf "%s\n" "$SEP2"
    fi
}

dwm_ccurse
