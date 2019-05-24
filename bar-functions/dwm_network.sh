#!/bin/sh

# A dwm_bar function to show the current network connection, private IP, and public IP
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager, curl

dwm_network () {
    CONNAME=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
    PRIVATE=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')
    PUBLIC=$(curl -s https://ipinfo.io/ip)

    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "[🌐 %s %s | %s]\n" "$CONNAME" "$PRIVATE" "$PUBLIC"
    else
        printf "[NET %s %s | %s]\n" "$CONNAME" "$PRIVATE" "$PUBLIC"
    fi
}

dwm_network
