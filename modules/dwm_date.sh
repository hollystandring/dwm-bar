#!/bin/sh

# A dwm-bar module that shows the current local date and time
# Joe Standring <git@joestandring.com>
# https://github.com/joestandring/dwm-bar/blob/master/modules/dwm_date.sh
# GNU GPLv3

# OPTIONS
# -i Identifier to be displayed before module data e.g. ""
# -f Date format string. See "date --help" for variables e.g. "%d %b %T"
# -s Seperator displayed before module e.g. "["
# -S Seperator displayed after module e.g. "]"
# -c Hexidecimal forground and background color values for identifier formatted
#    as "identifier fg identifier bg". Requires status2d e.g. "#21222c #bd93f9"
# -C Hexidecimal forground and background color values for data formatted as
#    "identifier fg identifier bg". Requires status2d e.g. "#bd93f9 #21222c"

dwm_date() {
    while getopts "i:f:s:S:c:C:" OPT; do
        case "$OPT" in
            # Set the identifier that displays before data
            i)
                IDEN="$OPTARG "
                ;;
            # Apply supplied date format
            f)
                FORMAT="$OPTARG"
                ;;
            # Set the first seperator that is displayed first in the module
            s)
                SEP1="$OPTARG"
                ;;
            # Set the second seperator that is displayed last in the module
            S)
                SEP2="$OPTARG"
                ;;
            # Apply colors to the identifier and reset
            c)
                set_iden_colors "$OPTARG"
                ;;
            # Apply colors to the main module body and reset
            C)
                set_data_colors "$OPTARG"
                ;;
            *)
                printf "dwm-bar: dwm_date: invalid option -- %s\n" "$OPTARG" >&2
                exit 1
                ;;
        esac
    done

    # Set data to current date with format
    if [ "$FORMAT" = "" ]; then
        DATA=$(date)
    else
        DATA=$(date "+$FORMAT")
    fi

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