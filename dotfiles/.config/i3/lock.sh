#!/bin/bash

# Set keyboard layout to en
~/.config/i3/keyboard-layout.sh set us

# Don't start i3lock if already running
pgrep -u $UID -x i3lock && exit 0

# Most important:
# Once we've started the lockscreen in fullscreen, our default xidlehook won't
# trigger a suspend anymore, now we're responsible on our own to suspend the
# machine after a certain timeout in locked mode.
xidlehook --timer 300 "systemctl suspend" "" &
XIDLEHOOK=$!

# Start matrix rain in foreground
i3-sensible-terminal -f -e "sleep 1; i3-msg fullscreen enable global; unimatrix -afs 97 -l kkkknnssss" &

# Start lockscreen
sleep 1.5
XSS_SLEEP_LOCK_FD=$XSS_SLEEP_LOCK_FD i3lock -n

# At this stage, the session has been unlocked. Now we shall end the
# matrix rain too.
kill -SIGINT $XIDLEHOOK
pgrep unimatrix | xargs kill -SIGINT

exit 0
