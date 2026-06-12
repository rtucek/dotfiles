{ pkgs, lib, ... }:
let
  find = "${lib.getExe pkgs.findutils}";
  cat = "${lib.getBin pkgs.coreutils-full}/bin/cat";
  head = "${lib.getBin pkgs.coreutils-full}/bin/head";
  jq = "${lib.getExe pkgs.jq}";
in
pkgs.writeShellScriptBin "capslock-check.sh" ''
  while true
  do
    # Check if caps-lock LED is enabled for first-best input device
    CAPS_ON="$(${cat} "$(${find} /sys/class/leds/input*::capslock/ -name 'brightness' | ${head} -1)")"

    # empty string causes waybar to show nothing
    TEXT="{ \"text\": \"\"}"

    if [[ "$CAPS_ON" == "1" ]]; then
      TEXT="{ \"text\": \"󰘲\", \"class\": \"active\"}"
    fi

    echo "$TEXT" | ${jq} --unbuffered --compact-output
    sleep 1
  done
''
