#!/bin/sh

# A dwm_bar function that shows the current date and time
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Date is formatted like like this: "[Mon 01-01-00 00:00:00]"
dwm_date () {
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "[📆 %s]\n" "$(date "+%a %d-%m-%y %T")"
    else
        printf "[DAT %s]\n" "$(date "+%a %d-%m-%y %T")"
    fi
}

dwm_date
