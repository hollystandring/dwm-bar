#!/bin/sh

# A dwm_bar function to show VPN connections (if any are active)
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: NetworkManager-openvpn

dwm_vpn () {
    VPN=$(nmcli -a | grep 'VPN connection' | sed -e 's/\( VPN connection\)*$//g')
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$VPN" != "" ]; then
            printf "[🔒 %s]\n" "$VPN"
        fi
    else
        if [ "$VPN" != "" ]; then
            printf "[VPN %s]\n" "$VPN"
        fi
    fi
}


dwm_vpn
