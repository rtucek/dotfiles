{ pkgs, ... }:
{
  home.packages = [
    pkgs.rofi
  ];

  programs.rofi = {
    enable = true;
    theme = "sidebar";
  };
}
