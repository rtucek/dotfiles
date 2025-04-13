#!/bin/bash

# set -x

# Get current brightness in percent
BRIGHTNESS="$(brightnessctl -m | cut -d',' -f4 | grep -Po '\d+')"
DIFF="$(echo "$1" | grep -Po "[\+\-]\d+(?=%)")"

# Round properly
TARGET_BRIGHTNESS="$(( (("$BRIGHTNESS" / 5) * 5) + "$DIFF" ))"

# Do not go beyond the boundaries of 0 and 100
TARGET_BRIGHTNESS="$(( 0 <= $TARGET_BRIGHTNESS ? $TARGET_BRIGHTNESS : 0 ))"
TARGET_BRIGHTNESS="$(( $TARGET_BRIGHTNESS <= 100 ? $TARGET_BRIGHTNESS : 100 ))"

# Set brightness
brightnessctl set "${TARGET_BRIGHTNESS}%"

# Show the brightness notification
notify-send \
	-a "changeBrightness" \
	-u normal \
	-t 1500 \
	-i /usr/share/icons/Tela-circle-manjaro/symbolic/status/display-brightness-symbolic.svg \
	-h string:synchronous:my-progress "Brightness: ${BRIGHTNESS}"
