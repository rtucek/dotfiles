#!/bin/bash

# Active sink
SINK=$(pacmd list-sinks | perl -n -e'/^\s*\*\s+index:\s+([0-9]+)$/ && print $1' | head -n 1)

pactl "$1" $SINK "$2" > /dev/null

VOLUME=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(($SINK + 1)) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
MUTE=$(pactl list sinks | grep '^[[:space:]]Mute:' | head -n $(($SINK + 1)) | tail -n 1 | sed -e 's,.*\(yes\|no\).*,\1,')

# As as special case, unmute if already muted, but volume change request
if [[ "$MUTE" == "yes" && "$1" == "set-sink-volume" ]]; then
	pactl "set-sink-mute" $SINK "toggle"
	MUTE="no"
fi

if [[ $VOLUME == 0 || "$MUTE" == "yes" ]]; then
	# Show the sound muted notification
	notify-send \
		-a "changeVolume" \
		-u low \
		-t 500 \
		-i audio-volume-muted-symbolic.symbolic \
		-h string:synchronous:my-progress "Volume muted"
else
	# Show the volume notification
	notify-send \
		-a "changeVolume" \
		-u low \
		-t 500 \
		-i audio-volume-high-symbolic.symbolic \
		-h int:value:$VOLUME \
		-h string:synchronous:my-progress "Volume: ${VOLUME}%"
fi

# Play the volume changed sound
paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
