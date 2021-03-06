#!/bin/bash

# Source: https://github.com/porras/i3-keyboard-layout
# Revision: 6e11b44c3debc29889d5e9860422fb9e93266f3a

set -e

get_kbdlayout() {
	setxkbmap -query | grep -oP 'layout:\s*\K(\w+)'
}

set_kbdlayout() {
	setxkbmap "$1"
	pgrep i3status | xargs --no-run-if-empty kill -s USR1 # tell i3status to update
}

cycle() {
	current_layout=$(get_kbdlayout)
	layouts=("$@" "$1") # add the first one at the end so that it cycles
	index=0
	while [ "${layouts[$index]}" != "$current_layout" ] && [ $index -lt "${#layouts[@]}" ]; do index=$[index +1]; done
	next_index=$[index +1]
	next_layout=${layouts[$next_index]}
	set_kbdlayout "$next_layout"
}

subcommand="$1"
shift || (echo "Please specify one of: get, set <layout>, cycle <layout1> <layout2> ... <layoutN>" && exit)

case $subcommand in
	"get")
		echo -n $(get_kbdlayout)
		;;
	"set")
		set_kbdlayout "$1"
		;;
	"cycle")
		cycle "$@"
		;;
esac
