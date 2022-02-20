#!/bin/bash

return_3() {
	echo "${3}"
}

modem=$(find_modem)
[ "${modem}" ] &&  operator="$( return_3 $(mmcli -m any --output-keyvalue | grep modem.3gpp.operator-name))"
battery=$(cat /sys/class/power_supply/axp20x-battery/capacity)
ac=$(cat /sys/class/power_supply/axp20x-usb/online)
bt=$(cat /sys/class/bluetooth/hci0/rfkill*/state)
link=$(cat /sys/class/net/wlan0/operstate)

bicon=""
(( battery <= 100 && battery > 75 )) && bicon=""
(( battery <= 75 && battery > 50 )) && bicon=""
(( battery <= 50 && battery > 25 )) && bicon=""
(( battery <= 25 && battery > 10 )) && bicon=""

status=

(( bt )) && status="${status} "
[ "${link}" == "up" ] && status="${status} "
[ "${modem}" ] && status="${status} ${operator}"
(( ac )) && status="${status} "

echo "$(date '+%a, %d %b %H:%M')${status} ${bicon}"
exit 0
