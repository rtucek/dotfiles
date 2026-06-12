{ pkgs, lib, ... }:
let
  cut = "${lib.getBin pkgs.coreutils-full}/bin/cut";
  grep = "${lib.getBin pkgs.gnugrep}/bin/grep";
  brightnessctl = "${lib.getExe pkgs.brightnessctl}";
  notify-send = "${lib.getExe pkgs.libnotify}";

  tela-circle-icon-theme."display-brightness-symbolic.svg" =
    "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/symbolic/status/display-brightness-symbolic.svg";
in
pkgs.writeShellScriptBin "backlight.sh" ''
  BRIGHTNESS="$(${brightnessctl} -m | ${cut} -d',' -f4 | ${grep} -Po '\d+')"
  DIFF="$(echo "$1" | ${grep} -Po "[\+\-]\d+(?=%)")"

  # Round properly
  TARGET_BRIGHTNESS="$(( (("$BRIGHTNESS" / 5) * 5) + "$DIFF" ))"

  # Do not go beyond the boundaries of 0 and 100
  TARGET_BRIGHTNESS="$(( 0 <= $TARGET_BRIGHTNESS ? $TARGET_BRIGHTNESS : 0 ))"
  TARGET_BRIGHTNESS="$(( $TARGET_BRIGHTNESS <= 100 ? $TARGET_BRIGHTNESS : 100 ))"

  # Set brightness
  ${brightnessctl} set "''${TARGET_BRIGHTNESS}%"

  # Show the brightness notification
  ${notify-send} \
    -a "changeBrightness" \
    -u normal \
    -t 1500 \
    -i  ${tela-circle-icon-theme."display-brightness-symbolic.svg"} \
    -h string:synchronous:my-progress "Brightness: ''${BRIGHTNESS}"
''
