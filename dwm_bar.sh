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

# Get the directory this script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Messag displayed when entering invalid argument or when -h used
HELP="Usage: dwm-bar [OPTION]...
  -h Display this message.
  -c Specify config directory. Must contain a 'bar.conf' and modules directory
     otherwise '~/.config/dwm-bar' or files in the same directory as the script
     will be used. If no config can be found, default values are used.
  -r How many seconds between main bar refreshes. Individual modules use their
     own. Overrides config.
  -x Kill running instances of dwm-bar."

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

# Get provided flags with input
while getopts ":hc:r:x" OPT; do
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
        # Check for the existance of and use a user-specified config directory
        c)
            if [ -d "$OPTARG/modules" ]; then
                if [ -f "$OPTARG/bar.conf" ]; then
                    CONF="$OPTARG"
                else
                    printf "The sepcified config directory does not contain 'bar.conf'\n" >&2
                    exit 1
                fi
            else
                printf "The specified config directory does not contain a 'modules' directory\n" \
                >&2
                exit 1
            fi
            ;;
        # Change the delay between bar refreshes
        r)
            if [ "$OPTARG" -ge 0 ] 2> /dev/null; then
                ARG_REFRESH_RATE="$OPTARG"
            else 
                printf "Refresh rate must be a positive integer.\n" >&2
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
printf "Loading configuration at %s\n" "$CONF"
if [ -f "$CONF/bar.conf" ]; then
    . "$CONF/bar.conf"
else
    printf "No bar.conf found, using default options\n"
fi

# Override refresh rate if provided with -r
if [ "$ARG_REFRESH_RATE" != "" ]; then
    REFRESH_RATE="$ARG_REFRESH_RATE"
fi

# Source modules
. "$CONF/modules/dwm_date.sh"
. "$CONF/modules/dwm_pulse.sh"

# Output current main refresh rate and loaded modules with refresh rates
printf "Running dwm-bar with main refresh rate of %s seconds\n" "$REFRESH_RATE"

# Display module output every time refresh rate elapses
while true; do
    BAR=""
    BAR="$BAR$(eval "$MOD_1")"
    BAR="$BAR$(eval "$MOD_2")"

    xsetroot -name "$BAR  "
    sleep "$REFRESH_RATE"
done
