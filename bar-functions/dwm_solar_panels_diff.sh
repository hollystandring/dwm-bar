#!/bin/sh

dwm_solar_panel () {

	if [[ -f ~/.cache/solar_panel.cache ]];
	then
		read SID < ~/.cache/solar_panel.cache
		if [ "$SID" == "null" ];
		then
			#Getting session id
			SID=`curl -s --location --request POST 'http://192.168.1.126/dyn/login.json' \
				--header 'Content-Type: text/plain' \
				--data-raw '{"right":"usr","pass":"ciao1234"}' | jq .result.sid`
			SID=${SID//\"}
		fi
		#checks if it got a session token
		if [ "$SID" != "" ] || [ "$SID" != "null" ];
		then
			echo $SID > ~/.cache/solar_panel.cache
			#get data, don't modify a single line of this url,except for the IP(192.168.1.126)
			WATTS=$(curl -s --location --request POST "http://192.168.1.126/dyn/getValues.json?sid=$SID" \
				--header 'Content-Type: text/plain' \
			--data-raw '{"destDev":[],"keys":["6100_00543100","6800_008AA200","6100_40263F00","6800_00832A00","6180_08214800","6180_08414900","6180_08522F00","6400_00543A00","6400_00260100","6800_08811F00","6400_00462E00"]}' | jq '.result."0156-76BC3EC6"."6100_40263F00"."1"[0].val')

			if [ "$WATTS" == "" ] || [ "$WATTS" == "null" ];
			then
				echo "null" > ~/.cache/solar_panel.cache
			else
				WATTC=`bc <<< "scale=3; $WATTS / 1000"`
				printf  "%s💡 $WATTC W %s" "$SEP1" "$SEP2"
			fi
		fi
	else
		touch ~/.cache/solar_panel.cache

		echo "null" > ~/.cache/solar_panel.cache
	fi

}
dwm_solar_panel

