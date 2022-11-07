#!/bin/sh

# A dwm_bar function that shows the btc last price on binance
# antx-code <wkaifeng2007@163.com>
# GNU GPLv3

# Last price is formatted like like this: "[₿ 20890.8]"
binance_kline="https://dapi.binance.com/dapi/v1/ticker/24hr?symbol=BTCUSD_PERP"
btc_icon="₿"
dwm_binance () {
    http_code=`curl -I -m 10 -o /dev/null -s -w %{http_code} $binance_kline`

    if [ "$http_code" -eq "405" ]
    then
#      last_price=`curl -s $binance_kline | jq -r '.[0].lastPrice'`
      last=`curl -v --stderr - $binance_kline | grep -oP '(?<="lastPrice":")[^"]*'`
      last_price=`awk -v x=1 -v y=$last 'BEGIN{printf "%.2f\n",x*y}'`
    else
      last_price="NError"
    fi
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "$btc_icon %s" "$last_price"
    else
        printf "BTC %s" "$last_price"
    fi
    printf "%s\n" "$SEP2"
}

dwm_binance
