#!/bin/sh

# A dwm_bar function to read the battery level and status
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_battery () {
    # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    CHARGE=$(cat /sys/class/power_supply/BAT1/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT1/status)

    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATUS" = "Charging" ]; then
            printf "[🔌 %s%% %s]\n" "$CHARGE" "$STATUS"
        else
            printf "[🔋 %s %%%s]\n" "$CHARGE" "$STATUS"
        fi
    else
        printf "[BAT %s%% %s]\n" "$CHARGE" "$STATUS"
    fi
}

dwm_battery

