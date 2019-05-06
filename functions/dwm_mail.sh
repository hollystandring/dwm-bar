#!/bin/sh

# A dwm_bar function to display the number of emails in an inbox
# Joe Standring <jstandring@pm.me>
# GNU GPLv3

# To count mail in an inbox, change "/path/to/inbox" below to the location of your inbox. For example, "/home/$USER/.mail/new"

dwm_mail () {
    MAILBOX=$(ls /path/to/inbox | wc -l)
    if [ $MAILBOX -eq 0 ]; then
        printf "[\U1F4ED $MAILBOX]\n"
    else
        printf "[\U1F4EB $MAILBOX]\n"
    fi
}
dwm_mail
