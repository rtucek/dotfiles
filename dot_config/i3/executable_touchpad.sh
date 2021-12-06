#!/bin/bash

TOUCHPAD="$(xinput --list --name-only | grep 'Touchpad')"

xinput --set-prop "$TOUCHPAD" "libinput Natural Scrolling Enabled" 1
xinput --set-prop "$TOUCHPAD" "libinput Disable While Typing Enabled" 1
