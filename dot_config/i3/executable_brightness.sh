#!/bin/bash

# Set brightness
brightnessctl set "$1"

# Get current brightness
BRIGHTNESS="$(brightnessctl -m | cut -d',' -f4)"

# Show the brightness notification
notify-send \
	-a "changeBrightness" \
	-u low \
	-t 500 \
	-i display-brightness-symbolic.symbolic \
	-h int:value:${BRIGHTNESS} \
	-h string:synchronous:my-progress "Brightness: ${BRIGHTNESS}"
