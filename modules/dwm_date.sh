#!/bin/sh

# A dwm-bar module that shows the current local date and time
# Joe Standring <git@joestandring.com>
# https://github.com/joestandring/dwm-bar/blob/master/modules/dwm_date.sh
# GNU GPLv3

# OPTIONS
# -i Identifier to be displayed before module data e.g. ""
# -d Date format string. See "date --help" for variables e.g. "%d %b %T"
# -s Seperator displayed before module e.g. "["
# -S Seperator displayed after module e.g. "]"
# -c Hexidecimal forground and background color values for identifier formatted
#    as "identifier fg identifier bg". Requires status2d e.g. "#21222c #bd93f9"
# -C Hexidecimal forground and background color values for data formatted as
#    "identifier fg identifier bg". Requires status2d e.g. "#bd93f9 #21222c"

dwm_date() {
    DATA=$(date) # Use default format if none selected

    while getopts "i:d:s:S:c:C:" OPT; do
        case "$OPT" in
            i) # Set the identifier that displays before data
                IDEN="$OPTARG "
                ;;
            d) # Apply supplied date format
                DATA=$(date "+$OPTARG")
                ;;
            s) # Set the first seperator that is displayed first in the module
                SEP1="$OPTARG"
                ;;
            S) # Set the second seperator that is displayed last in the module
                SEP2="$OPTARG"
                ;;
            c) # Apply colors to the identifier and reset
                IDEN_COL_FG="^c$(printf "%s" "$OPTARG" | cut -d' ' -f1)^"
                IDEN_COL_BG="^b$(printf "%s" "$OPTARG" | cut -d' ' -f2)^ "
                IDEN_COL_RESET="^d^"
                ;;
            C) # Apply colors to the main module body and reset
                DATA_COL_FG="^c$(printf "%s" "$OPTARG" | cut -d' ' -f1)^"
                DATA_COL_BG="^b$(printf "%s" "$OPTARG" | cut -d' ' -f2)^ "
                DATA_COL_RESET=" ^d^"
                ;;
        esac
    done

    # Print data used by dwm_bar.sh
    printf "%s%s%s%s%s%s%s%s%s%s" \
        "$SEP1" \
        "$IDEN_COL_FG" \
        "$IDEN_COL_BG" \
        "$IDEN" \
        "$IDEN_COL_RESET" \
        "$DATA_COL_FG" \
        "$DATA_COL_BG" \
        "$DATA" \
        "$DATA_COL_RESET" \
        "$SEP2"
}