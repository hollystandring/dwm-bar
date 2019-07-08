#!/bin/sh

# A dwm_bar function to show VPN connections (if any are active)
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager-openvpn

dwm_vpn () {
    VPN=$(nmcli -a | grep 'VPN connection' | sed -e 's/\( VPN connection\)*$//g')

    if [ "$VPN" != "" ]; then
        printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
            printf "🔒 %s" "$VPN"
        else
            printf "VPN %s" "$VPN"
        fi
        printf "%s\n" "$SEP2"
    fi
}


dwm_vpn
