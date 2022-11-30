#!/bin/sh

# A dwm_bar function that shows public ip and local ip.
# antx-code <wkaifeng2007@163.com>
# GNU GPLv3

# IP is formatted like this: "[IP 127.0.0.1]"
ip_icon="IP"
dwm_ip () {
    randomNumber=`shuf -i 1-100 -n 1`
    aa=$(($randomNumber%2))

    if [ $aa -eq 0 ]
    then
      #IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
      IP=$(curl ip.cip.cc)

      if [[ "$IP" == "" ]]; then
          IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
      fi
    else
      IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
    fi
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "$ip_icon %s" "$IP"
    else
        printf "IP %s" "$IP"
    fi
    printf "%s\n" "$SEP2"
}

dwm_ip
