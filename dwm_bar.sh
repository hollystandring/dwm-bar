#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# https://github.com/joestandring/dwm-bar
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Create a PID file used to identify is dwm-bar is running
PID_FILE="$XDG_RUNTIME_DIR/dwm-bar.pid"

# Kill process and remove .pid file
kill_bar() {
    read -r PID < "$PID_FILE"
        kill "$PID"
        rm -f "$PID_FILE"
    exit $1
}

# Check that colors are valid (prevents status2d crashing)
color_valid() {
    if [ $(expr length "$1") -eq 6 ]; then
        if ! printf "%s" "$1" | grep -qE "[0-9A-Fa-f]{6}"; then
            printf "'#%s' is not a valid hex color\n" "$1" >&2
            kill_bar 1
        fi
    else
        printf "'#%s' is not a valid hex color\n" "$1" >&2
        kill_bar 1
    fi 
}

set_iden_colors() {
    HEX_1="$(printf "%s" "$1" | cut -d' ' -f1)"
    HEX_2="$(printf "%s" "$1" | cut -d' ' -f2)"

    # Check if colors are valid
    if [ "$HEX_1" != "" ]; then
        color_valid "${HEX_1#?}"
    fi 
    if [ "$HEX_2" != "" ]; then
        color_valid "${HEX_2#?}"
    fi 

    IDEN_COL_FG="^c$HEX_1^"
    IDEN_COL_BG="^b$HEX_2^ "
    IDEN_COL_RESET="^d^"
}

set_data_colors() {
    HEX_1="$(printf "%s" "$1" | cut -d' ' -f1)"
    HEX_2="$(printf "%s" "$1" | cut -d' ' -f2)"

    # Check if colors are valid
    if [ "$HEX_1" != "" ]; then
        color_valid "${HEX_1#?}"
    fi 
    if [ "$HEX_2" != "" ]; then
        color_valid "${HEX_2#?}"
    fi 

    DATA_COL_FG="^c$HEX_1^"
    DATA_COL_BG="^b$HEX_2^ "
    DATA_COL_RESET="^d^ "
}

# Get the directory this script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Messag displayed when entering invalid argument or when -h used
HELP="Usage: dwm-bar [OPTION]...
  -h Display this message.
  -c Specify config file location, otherwise '~/.config/dwm-bar/bar.conf', a
     'bar.conf' in the script directory, or default values will be used.
  -m Specify modules directory, otherwise '/usr/local/share/dwm-bar-modules/'
     or 'modules' in the script directory will be used.
  -r How many seconds between main bar refreshes. Individual modules use their
     own. Overrides config.
  -x Kill running instances of dwm-bar."

# Default values used when no config provided
MOD_1="dwm_date -i '' -f '%d %b %T' -s '[' -S ']'"
REFRESH_RATE=1

# Check the user's .config for a modules directory and bar.conf
if [ -f ~/.config/dwm-bar/bar.conf ]; then
    CONF=~/.config/dwm-bar/bar.conf
elif [ -f "$DIR/bar.conf" ]; then
    CONF="$DIR/bar.conf"
fi

# Check for modules in /usr/local/share or local directory
if [ -d /usr/local/share/dwm-bar-modules ]; then
    MODULES=/usr/local/share/dwm-bar-modules
elif [ -d "$DIR/modules" ]; then
    MODULES="$DIR/modules"
fi

# Get provided flags with input
while getopts ":hc:m:r:x" OPT; do
    case "$OPT" in
        # Print program information and help
        h)
            printf "%s\n\n%s\n%s\n%s\n\n%s\n" \
                "A modular status bar for dwm" \
                "Joe Standring <git@joestandring.com>"\
                "https://github.com/joestandring/dwm-bar"\
                "GNU GPLv3"\
                "$HELP"
            exit 0
            ;;
        # Check for the existance of and use a user-specified config file
        c)
            if [ -f "$OPTARG" ]; then
                CONF="$OPTARG"
            else
                printf "The specified config file does not exist\n" >&2
                exit 1
            fi
            ;;
        # Check for the existance of and use a user-specified modules directory
        m)
            if [ -d "$OPTARG" ]; then
                MODULES="$OPTARG"
            else
                printf "The specified modules directory does not exist\n" >&2
                exit 1
            fi
            ;;
        # Change the delay between bar refreshes
        r)
            if [ "$OPTARG" -ge 0 ] 2> /dev/null; then
                ARG_REFRESH_RATE="$OPTARG"
            else 
                printf "Refresh rate must be a positive integer\n" >&2
                exit 1
            fi
            ;;
        # Kill running dwm-bar instances if found
        x)
            if [ -f "$XDG_RUNTIME_DIR/dwm-bar.pid" ]; then
                kill_bar 0
            else
                printf "No instances of dwm-bar are running (no dwm-bar.pid found in %s/)\n" \
                "$XDG_RUNTIME_DIR" >&2
                exit 1
            fi
            ;;
        # Inform the user the option is invalid and display help
        *)
            printf "dwm-bar: invalid option -- %s\n\n%s\n" "$OPTARG" "$HELP"
            exit 1
            ;;
    esac
done

# Check if dwm-bar is already running and prevent exit if so
if [ -f "$XDG_RUNTIME_DIR/dwm-bar.pid" ]; then
    printf "An instance of dwm-bar is already running. %s\n" \
    "Run dwm-bar -x to kill any running instances" >&2
    exit 1
else 
    # Populate PID with current PID
    printf "%s" "$$" > "$PID_FILE"
fi

# Remove PID file on exit/termination
trap 'rm -f "$PID_FILE"; trap - EXIT; exit 0' EXIT INT QUIT HUP

# Source configuration file
printf "Loading configuration at %s\n\n" "$CONF"
if [ -f "$CONF" ]; then
    . "$CONF"
else
    printf "No config found, using default options\n"
fi

# Source modules in modules directory
if [ -d "$MODULES" ]; then
    for MODULE in "$MODULES/"*; do
        printf "Loading %s\n" "$MODULE"
        if [ -f "$MODULE" ]; then
            . "$MODULE"
        fi
    done
else
    printf "No modules directory found. Specify one with -m or install the script.\n" >&2
fi

# Override refresh rate if provided with -r
if [ "$ARG_REFRESH_RATE" != "" ]; then
    REFRESH_RATE="$ARG_REFRESH_RATE"
fi

# Output current main refresh rate and loaded modules with refresh rates
printf "\nRunning dwm-bar with main refresh rate of %s second(s)...\n" "$REFRESH_RATE"

# Display module output every time refresh rate elapses
while true; do
    BAR=""
    BAR="$BAR$(eval "$MOD_1")"
    BAR="$BAR$(eval "$MOD_2")"

    xsetroot -name "$BAR  "
    sleep "$REFRESH_RATE"
done
