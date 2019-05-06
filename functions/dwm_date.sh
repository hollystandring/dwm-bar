#!/bin/sh

# A dwm_bar function that shows the current date and time
# Joe Standring <jstandring@pm.me>
# GNU GPLv3

# Date is formatted like like this: "[Mon 01-01-00 00:00:00]"
dwm_date () {
    printf "[\U23F2 $(date "+%a %d-%m-%y %T")]\n"
}
dwm_date
