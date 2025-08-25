#!/bin/bash

# set -x

VOLUME="$(pactl get-sink-volume "@DEFAULT_SINK@" | grep -Po '\d+(?=%)' | head -n 1)"
MUTED="$(pactl get-sink-mute @DEFAULT_SINK@ | grep -Po 'yes|no')"

if [[ "$1" == "mute" && "$2" == "toggle" ]]; then
	# toggle mute
	pactl set-sink-mute @DEFAULT_SINK@ toggle

	MSG="Volume muted"
	ICON="/usr/share/icons/Tela-circle-manjaro/24/panel/audio-volume-muted-blocking.svg"
	if [[ "$MUTED" == "yes" ]]; then
		# in this case, we toggle to unmute
		MSG="Volume unmuted"
		ICON="/usr/share/icons/Tela-circle-manjaro/24/panel/audio-volume-muted.svg"
	fi

	notify-send \
		-a "changeVolume" \
		-u normal \
		-t 1500 \
		-i "$ICON" \
		-h string:synchronous:my-progress "$MSG"

	exit 0
fi

if [[ "$1" == "volume" ]]; then
	# Force unmuting upon changing sound
	pactl set-sink-mute "@DEFAULT_SINK@" no

	DIFF="$(echo "$2" | grep -Po "[\+\-]\d+(?=%)")"

	# Round properly
	TARGET_VOLUME="$(( (("$VOLUME" / 5) * 5) + "$DIFF" ))"

	# Do not go beyond the boundaries of 0 and 100
	TARGET_VOLUME="$(( 0 <= $TARGET_VOLUME ? $TARGET_VOLUME : 0 ))"
	TARGET_VOLUME="$(( $TARGET_VOLUME <= 100 ? $TARGET_VOLUME : 100 ))"

	# set again with properly rounded value
	pactl set-sink-volume "@DEFAULT_SINK@" "${TARGET_VOLUME}%"

	# icon to display
	ICON="/usr/share/icons/Tela-circle-manjaro/24/panel/audio-volume-low.svg"
	if [[ "$TARGET_VOLUME" -ge "33" ]]; then
		ICON="/usr/share/icons/Tela-circle-manjaro/24/panel/audio-volume-medium.svg"
	fi
	if [[ "$TARGET_VOLUME" -ge "66" ]]; then
		ICON="/usr/share/icons/Tela-circle-manjaro/24/panel/audio-volume-high.svg"
	fi

	# Show the volume notification
	notify-send \
		-a "changeVolume" \
		-u normal \
		-t 1500 \
		-i "$ICON" \
		-h string:synchronous:my-progress "Volume: ${TARGET_VOLUME}%"

	# Play the volume changed sound
	paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
fi
