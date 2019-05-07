#!/bin/sh

# A dwm_bar function to print the weather from wttr.in
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: curl

# Change the value of LOCATION to match your city
dwm_weather() {
    LOCATION=city
    printf "[$(curl -s wttr.in/$LOCATION?format=1)]\n"
}
dwm_weather
