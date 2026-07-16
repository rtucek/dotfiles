{ pkgs, ... }:
{
  home.packages = [
    pkgs.fastfetch
    pkgs.fortune
    pkgs.gitlogue
    pkgs.pwgen
  ];
}
