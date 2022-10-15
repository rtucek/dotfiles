#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
	for m in $(xrandr --listactivemonitors | tail -n +2 | grep  -Eo '\b([A-Za-z0-9_\-]+)$'); do
		MONITOR=$m polybar --reload top &
	done
else
	polybar --reload top &
fi
