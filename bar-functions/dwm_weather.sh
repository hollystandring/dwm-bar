#!/bin/sh

# A dwm_bar function to print the weather from wttr.in
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: curl

# Change the value of LOCATION to match your city
dwm_weather() {
    LOCATION=London

    if [ "$IDENTIFIER" = "unicode" ]; then
        DATA=$(curl -s wttr.in/$LOCATION?format=1)
        export __DWM_BAR_WEATHER__="${SEP1} ${DATA} ${SEP2}" 
    else
        DATA=$(curl -s wttr.in/$LOCATION?format=1 | grep -o ".[0-9].*")
        export __DWM_BAR_WEATHER__="${SEP1} WEA ${DATA} ${SEP2}"
    fi
}

dwm_weather
