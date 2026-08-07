{ lib, pkgs, ... }:
let
  find = "${lib.getExe pkgs.findutils}";
  xargs = "${lib.getBin pkgs.findutils}/bin/xargs";
  grep = "${lib.getExe pkgs.gnugrep}";
  sed = "${lib.getExe pkgs.gnused}";

  # Prevent auto-suspension of connected mouse, keyboard and yubikey hardware
  powertopPostScript = pkgs.writeShellScriptBin "powertop-post-script.sh" ''
    DEVS="$(
      ${find} -L /sys/bus/usb/devices/ -maxdepth 2 -type f -name 'product' -print0 \
        | ${xargs} -0 ${grep} -liE "mouse|keyboard|yubikey" \
    )"

    if [[ "$DEVS" == "" ]]; then
      echo "no devices"

      exit 0
    fi

    while IFS= read -r DEV; do
      DEV_POWER_CONTROL="$(echo "$DEV" | ${sed} "s/product/power\\/control/")"
      echo "Keeping "$(cat "$DEV")" enabled ("$DEV")"
      echo "on" >| "$DEV_POWER_CONTROL"
    done <<< "$DEVS"
  '';
in
{
  environment.systemPackages = [
    pkgs.powertop
  ];

  powerManagement = {
    enable = true;

    powertop = {
      enable = true;
      postStart = "${powertopPostScript}/bin/powertop-post-script.sh";
    };
  };

  services = {
    logind = {
      enable = true;

      settings.Login = {
        SleepOperation = "suspend-then-hibernate suspend";
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
        HandleLidSwitchDocked = "suspend";
      };
    };

    auto-cpufreq = {
      enable = true;
    };

    upower = {
      enable = true;
    };
  };
}
