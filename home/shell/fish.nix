{ lib, pkgs, ... }:
let
  inherit (import ./bt-devices.nix { inherit lib pkgs; }) btDevices bluetoothctl;

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
      # Disable greeting
      set fish_greeting

      # Avoid having Ctrl + d closing the shell
      bind \cd delete-char

      ${builtins.concatStringsSep "\n" btConnFuncs}
    '';
  };
}
