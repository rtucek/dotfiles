#!/bin/bash

if [[ "$(pgrep -u $UID -x xss-lock)" ]]; then
	# kill any existing xss-lock process for our user
	killall --user $USER xss-lock
fi

xss-lock --transfer-sleep-lock -- $HOME/.config/i3/lock.sh
