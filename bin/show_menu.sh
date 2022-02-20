#!/bin/bash

if [ "$(pidof wofi)" ]; then
	kill $(pidof wofi)
	exit 0
fi

wofi -W 80% -p "" -I --show drun &
exit 0

