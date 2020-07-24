#!/bin/bash

# Set keyboard layout to en
~/.config/i3/keyboard-layout.sh set us

# Take screenshot and blur it
import -window root /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x8 /tmp/screenshotblur.png
rm /tmp/screenshot.png

# Terminate already running lock screen instances
killall -q i3lock

# Wait until the processes have been shut down
while pgrep -u $UID -x i3lock >/dev/null; do sleep 1; done

case "$1" in
	--nofork)
		exec i3lock --nofork -i /tmp/screenshotblur.png
		;;
	*)
		# Lock the screen and fork
		i3lock -i /tmp/screenshotblur.png
		# sleep 1 adds a small delay to prevent possible race conditions with suspend
		sleep 1
		exit 0
esac

