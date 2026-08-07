{ pkgs, lib, ... }:
let
  bc = "${lib.getBin pkgs.bc}/bin/bc";
  wpctl = "${lib.getBin pkgs.wireplumber}/bin/wpctl";
  pw-play = "${lib.getBin pkgs.pipewire}/bin/pw-play";
  grep = "${lib.getBin pkgs.gnugrep}/bin/grep";
  notify-send = "${lib.getExe pkgs.libnotify}";
  sed = "${lib.getExe pkgs.gnused}";

  freedesktop-sounds-path =
    sound: "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/${sound}";
  freedesktop-sounds = {
    "audio-volume-change.oga" = freedesktop-sounds-path "audio-volume-change.oga";
  };

  tela-icon-path =
    icon: "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-light/24/panel/${icon}";
  tela-circle-icon-theme = {
    "audio-volume-muted-blocking.svg" = tela-icon-path "audio-volume-muted-blocking.svg";
    "audio-volume-muted.svg" = tela-icon-path "audio-volume-muted.svg";
    "audio-volume-low.svg" = tela-icon-path "audio-volume-muted.svg";
    "audio-volume-medium.svg" = tela-icon-path "audio-volume-medium.svg";
    "audio-volume-high.svg" = tela-icon-path "audio-volume-high.svg";
  };
in
pkgs.writeShellScriptBin "sound.sh" ''
  VOLUME="$(printf '%f * 100\n' "$(${wpctl} get-volume "@DEFAULT_SINK@" | ${grep} -Eo '[-+]?[0-9]+(\.[0-9]+)?')" | ${bc} -l | ${sed} -E 's/^([0-9]*)\.[0-9]*/\1/')"
  MUTED="$(if [[ "$(${wpctl} get-volume "@DEFAULT_SINK@" | ${grep} -Eo 'MUTED')" ]]; then echo yes; else echo no; fi)"

  if [[ "$1" == "mute" && "$2" == "toggle" ]]; then
    # toggle mute
    ${wpctl} set-mute "@DEFAULT_SINK@" toggle

    MSG="Volume muted"
    ICON="${tela-circle-icon-theme."audio-volume-muted-blocking.svg"}"
    if [[ "$MUTED" == "yes" ]]; then
      # in this case, we toggle to unmute
      MSG="Volume unmuted"
      ICON="${tela-circle-icon-theme."audio-volume-muted.svg"}"
    fi

    ${notify-send} \
      -a "changeVolume" \
      -u normal \
      -t 1500 \
      -i "$ICON" \
      -h string:synchronous:my-progress "$MSG"

    exit 0
  fi

  if [[ "$1" == "volume" ]]; then
    # Force unmuting upon changing sound
    ${wpctl} set-mute @DEFAULT_SINK@ 0

    DIFF="$(echo "$2" | ${grep} -Po "[\+\-]\d+(?=%)")"

    # Round properly
    TARGET_VOLUME="$(( (("$VOLUME" / 5) * 5) + "$DIFF" ))"

    # Do not go beyond the boundaries of 0 and 100
    TARGET_VOLUME="$(( 0 <= $TARGET_VOLUME ? $TARGET_VOLUME : 0 ))"
    TARGET_VOLUME="$(( $TARGET_VOLUME <= 100 ? $TARGET_VOLUME : 100 ))"

    # Set again with properly rounded value
    # As a special case, wpctl wants to target volume as a fraction.
    # That is, 50 % => 0.50; 100 % => 1.00; etc
    ${wpctl} set-volume "@DEFAULT_SINK@" "$(printf '%.2f' "$(echo "$TARGET_VOLUME / 100" | ${bc} -l)")"

    # icon to display
    ICON="${tela-circle-icon-theme."audio-volume-low.svg"}"
    if [[ "$TARGET_VOLUME" -ge "33" ]]; then
      ICON="${tela-circle-icon-theme."audio-volume-medium.svg"}"
    fi
    if [[ "$TARGET_VOLUME" -ge "66" ]]; then
      ICON="${tela-circle-icon-theme."audio-volume-high.svg"}"
    fi

    # Show the volume notification
    ${notify-send} \
      -a "changeVolume" \
      -u normal \
      -t 1500 \
      -i "$ICON" \
      -h string:synchronous:my-progress "Volume: ''${TARGET_VOLUME}%"

    # Play the volume changed sound
    ${pw-play} "${freedesktop-sounds."audio-volume-change.oga"}"
  fi
''
