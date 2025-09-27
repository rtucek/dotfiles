#!/bin/bash

# Toggle rfkill switches
rfkill --json | jq --raw-output0 '.rfkilldevices | map(.type) | .[]' | xargs -0 -L1 rfkill toggle

# Check current status on first-best device
STATUS="$(rfkill --json | jq -r '.rfkilldevices[0].soft')"

# Show notification
UNBLOCKED="/usr/share/icons/Tela-circle-manjaro/22/panel/network-flightmode-off.svg"
BLOCKED="/usr/share/icons/Tela-circle-manjaro/22/panel/network-flightmode-on.svg"

ICON="$UNBLOCKED"
STATUS_TXT="off"
if [[ $STATUS == "blocked" ]]; then
	ICON="$BLOCKED"
	STATUS_TXT="on"
fi

notify-send \
	-a "changeFlightmode" \
	-u normal \
	-t 1500 \
	-i "$ICON" \
	-h string:synchronous:my-progress "Flightmode: $STATUS_TXT"
