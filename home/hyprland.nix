{ lib, pkgs, ... }:
{
  home.packages = [
    pkgs.kitty
    pkgs.pcmanfm
    pkgs.rofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd.enable = true;
    systemd.variables = [ "--all" ];
  };
}
