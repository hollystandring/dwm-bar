#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <jstandring@pm.me>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')
    # CPU temperature
    CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)
    # Used and total storage in /home (rounded to 1024B)
    STOUSED=$(df -h | grep '/home' | awk '{print $3}')
    STOTOT=$(df -h | grep '/home' | awk '{print $2}')
    STOPER=$(df -h | grep '/home' | awk '{print $5}')

    printf "[\U1F5A5 MEM $MEMUSED/$MEMTOT CPU $CPU STO $STOUSED/$STOTOT: $STOPER%]\n"
}
dwm_resources
