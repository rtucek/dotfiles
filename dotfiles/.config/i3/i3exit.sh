#!/bin/bash

# with openrc use loginctl
[ "$(cat /proc/1/comm)" = "systemd" ] && logind=systemctl || logind=loginctl

case "$1" in
	lock)
		$HOME/.config/i3/lock.sh --nofork
		;;
	logout)
		i3-msg exit
		;;
	switch_user)
		dm-tool switch-to-greeter
		;;
	suspend)
		$HOME/.config/i3/lock.sh && $logind suspend
		;;
	hibernate)
		$HOME/.config/i3/lock.sh && $logind hibernate
		;;
	reboot)
		$logind reboot
		;;
	shutdown)
		$logind poweroff
		;;
	*)
		echo "== ! i3exit: missing or invalid argument ! =="
		echo "Try again with: lock | logout | switch_user | suspend | hibernate | reboot | shutdown"
		exit 2
esac

exit 0
