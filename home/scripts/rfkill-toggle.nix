{ pkgs, lib, ... }:
let
  rfkill = "${lib.getBin pkgs.util-linux}/bin/rfkill";
  xargs = "${lib.getBin pkgs.findutils}/bin/xargs";
  jq = "${lib.getExe pkgs.jq}";
  notify-send = "${lib.getExe pkgs.libnotify}";

  tela-icon-path = icon: "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle/22/panel/${icon}";
  tela-circle-icon-theme = {
    "network-flightmode-off.svg" = tela-icon-path "network-flightmode-off.svg";
    "network-flightmode-on.svg" = tela-icon-path "network-flightmode-on.svg";
  };
in
pkgs.writeShellScriptBin "rfkill-toggle.sh" ''
  # Toggle rfkill switches
  ${rfkill} --json | ${jq} --raw-output0 '.rfkilldevices | map(.type) | .[]' | ${xargs} -0 -L1 ${rfkill} toggle

  # Check current status on first-best device
  STATUS="$(${rfkill} --json | ${jq} -r '.rfkilldevices[0].soft')"

  # Show notification
  UNBLOCKED="${tela-circle-icon-theme."network-flightmode-off.svg"}"
  BLOCKED="${tela-circle-icon-theme."network-flightmode-on.svg"}"

  ICON="$UNBLOCKED"
  STATUS_TXT="off"
  if [[ $STATUS == "blocked" ]]; then
    ICON="$BLOCKED"
    STATUS_TXT="on"
  fi

  ${notify-send} \
    -a "changeFlightmode" \
    -u normal \
    -t 1500 \
    -i "$ICON" \
    -h string:synchronous:my-progress "Flightmode: $STATUS_TXT"
''
