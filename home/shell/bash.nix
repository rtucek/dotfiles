{ lib, pkgs, ... }:
let
  inherit (import ./bt-devices.nix { inherit lib pkgs; }) btDevices bluetoothctl;

  btConnFuncs = map (dev: ''
    bt-connect-${dev.name}() {
      ${bluetoothctl} connect ${dev.mac}
    }
    bt-disconnect-${dev.name}() {
      ${bluetoothctl} disconnect ${dev.mac}
    }
  '') btDevices;
in
{
  programs.bash = {
    enable = true;

    enableCompletion = true;

    initExtra = ''
      ${builtins.concatStringsSep "\n" btConnFuncs}
    '';
  };
}
