{ lib, pkgs, ... }:
let
  btDevices = [
    {
      name = "jbl-private";
      mac = "28:6F:40:16:35:A5";
    }
    {
      name = "ekosphear-private";
      mac = "00:02:5B:07:E8:96";
    }
  ];

  bluetoothctl = "${lib.getBin pkgs.bluez}/bin/bluetoothctl";

  btConnFuncs = map (dev: ''
    function bt-connect-${dev.name}
      ${bluetoothctl} connect ${dev.mac}
    end
    function bt-disconnect-${dev.name}
      ${bluetoothctl} disconnect ${dev.mac}
    end
  '') btDevices;
in
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      ${builtins.concatStringsSep "\n" btConnFuncs}
    '';
  };
}
