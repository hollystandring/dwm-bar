#!/bin/sh

# A dwm_status function that displays the status of countdown.sh
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: https://github.com/joestandring/countdown

dwm_countdown () {
    if [ -e /tmp/countdown.* ]; then
        printf "[\U23F3 $(tail -1 /tmp/countdown.*)]"
    fi
}
dwm_countdown
