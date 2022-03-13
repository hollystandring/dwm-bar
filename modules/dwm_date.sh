#!/bin/sh

# A dwm-bar module that shows the current local date and time
# Joe Standring <git@joestandring.com>
# https://github.com/joestandring/dwm-bar/blob/master/modules/dwm_date.sh
# GNU GPLv3

# OPTIONS
# -i Identifier to be displayed before module data e.g. ""
# -f Date format string. See "date --help" for variables e.g. "%d %b %T"
# -s Seperator displayed before module e.g. "["
# -S Seperator displayed after module e.g. "]"
# -c Hexidecimal forground and background color values for identifier formatted
#    as "identifier fg identifier bg". Requires status2d e.g. "#21222c #bd93f9"
# -C Hexidecimal forground and background color values for data formatted as
#    "identifier fg identifier bg". Requires status2d e.g. "#bd93f9 #21222c"

dwm_date() {
    IDEN=""
    DATA=$(date)
    IDEN_FG=""
    IDEN_BG=""
    DATA_FG=""
    DATA_BG=""

    while getopts "i:f:s:S:c:C:" OPT; do
        case $OPT in
            i)
                IDEN="$OPTARG"
                ;;
            f)
                DATA=$(date "+$OPTARG")
                ;;
            s)
                SEP1="$OPTARG"
                ;;
            S)
                SEP2="$OPTARG"
                ;;
            c)
                IDEN_FG="^c$(printf "%s" "$OPTARG" | cut -d' ' -f1)^"
                IDEN_BG="^b$(printf "%s" "$OPTARG" | cut -d' ' -f2)^"
                ;;
            C)
                DATA_FG="^c$(printf "%s" "$OPTARG" | cut -d' ' -f1)^"
                DATA_BG="^b$(printf "%s" "$OPTARG" | cut -d' ' -f2)^"
                ;;
        esac
    done

    printf "%s%s%s %s %s%s %s %s^d^" "$SEP1" "$IDEN_FG" "$IDEN_BG" "$IDEN" "$DATA_FG" "$DATA_BG" "$DATA" "$SEP2"
}
