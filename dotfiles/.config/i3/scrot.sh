#!/bin/sh

_conf=$HOME/.config/i3-scrot.conf

if ! [ -f $_conf ]; then
	echo "scrot_dir=$(xdg-user-dir PICTURES)" > $_conf
fi

source $_conf

if ! [ -d $scrot_dir ]; then
	mkdir -p $scrot_dir
fi
cd $scrot_dir

MODE=""
EXEC=()
PRE_MSG=""
POST_MSG="screenshot has been saved in $scrot_dir"

while test $# != 0
do
	case "$1" in
	-d|--desktop)
	;;
	-u|--focused)
		MODE="--focused"
	;;
	-s|--select)
		MODE="--select"
		PRE_MSG="select an area for the screenshot"
	;;
	--clipboard)
		EXEC=("--exec" "xclip -selection clipboard -target image/png -i \$f && rm \$f")
		POST_MSG="screenshot has been saved to clipboard"
	;;
	esac
	shift
done

if [[ $PRE_MSG != "" ]]; then
	notify-send "$PRE_MSG" &
fi
scrot $MODE "${EXEC[@]}" &&
sleep 1 &&
notify-send "$POST_MSG"

exit 0
