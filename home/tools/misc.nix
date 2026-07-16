{ pkgs, ... }:
{
  home.packages = [
    pkgs.fastfetch
    pkgs.fortune
  ];
}
