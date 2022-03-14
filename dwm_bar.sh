#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# https://github.com/joestandring/dwm-bar
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Get the directory this script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Messag displayed when entering invalid argument or when -h used
HELPSTR="Usage: dwm-bar [OPTION]...
  -h Display this message
  -c Specify config directory. Must contain a 'bar.conf' and modules directory
     otherwise '~/.config/dwm-bar' or files in the same directory as the script
     will be used. If no config can be found, default values are used.
  -r How many seconds between bar refreshes. Overwrites config"

# Default values used when no config provided
MOD_1="dwm_date -i '' -f '%d %b %T' -s '[' -S ']'"
REFRESH_RATE=1

# Check the user's .config for a modules directory and bar.conf
CONF="$DIR"
if [ -d ~/.config/dwm-bar/modules ]; then
    if [ -f ~/.config/dwm-bar/bar.conf ]; then
        CONF=~/.config/dwm-bar/
    fi
fi

while getopts ":hc:r:" OPT; do
    case "$OPT" in
        h)
            printf "%s\n\n%s\n%s\n%s\n\n%s\n" \
                "A modular status bar for dwm" \
                "Joe Standring <git@joestandring.com>"\
                "https://github.com/joestandring/dwm-bar"\
                "GNU GPLv3"\
                "$HELPSTR"
            exit 0
            ;;
        c)
            if [ -d "$OPTARG/modules" ]; then
                if [ -f "$OPTARG/bar.conf" ]; then
                    CONF="$OPTARG"
                else
                    printf "The sepcified config directory does not contain 'bar.conf'" >&2
                    exit 1
                fi
            else
                printf "The specified config directory does not contain a 'modules' directory" >&2
                exit 1
            fi
            ;;
        r)
            if [ "$OPTARG" -ge 0 ] 2> /dev/null; then
                ARG_REFRESH_RATE="$OPTARG"
            else 
                printf "Refresh rate must be a positive integer" >&2
                exit 1
            fi
            ;;
        *)
            printf "dwm-bar: invalid option -- %s\n\n%s\n" "$OPTARG" "$HELPSTR"
            exit 1
            ;;
    esac
done

printf "Loading configuration at %s\n" "$CONF"
if [ -f "$CONF/bar.conf" ]; then
    . "$CONF/bar.conf"
else
    printf "No bar.conf found, using default options\n"
fi

if [ "$ARG_REFRESH_RATE" != "" ]; then
    REFRESH_RATE="$ARG_REFRESH_RATE"
fi

. "$CONF/modules/dwm_date.sh"
. "$CONF/modules/dwm_pulse.sh"

while true; do
    BAR=""
    BAR="$BAR$(eval "$MOD_1")"
    BAR="$BAR$(eval "$MOD_2")"

    xsetroot -name "$BAR  "
    sleep "$REFRESH_RATE"
done