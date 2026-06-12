{ pkgs, lib, ... }:
pkgs.writeShellScriptBin "capslock-check.sh" ''
  while true
  do
    # Check if caps-lock LED is enabled for first-best input device
    CAPS_ON="$(cat "$(find /sys/class/leds/input*::capslock/ -name 'brightness' | head -1)")"

    # empty string causes waybar to show nothing
    TEXT="{ \"text\": \"\"}"

    if [[ "$CAPS_ON" == "1" ]]; then
    	TEXT="{ \"text\": \"󰘲\", \"class\": \"active\"}"
    fi

    echo "$TEXT" | ${lib.getExe pkgs.jq} --unbuffered --compact-output
    sleep 1
  done
''
