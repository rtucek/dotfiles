#!/bin/bash

# Terminate already running i3-battery-popup instances
killall -q i3-battery-popup

# Wait until the processes have been shut down
while pgrep -u $UID -x i3-battery-popup >/dev/null; do sleep 1; done

i3-battery-popup -n -t 10s
