{ pkgs, ... }:
{
  home.packages = [
    pkgs.cowsay
    pkgs.fastfetch
    pkgs.fortune
    pkgs.gitlogue
    pkgs.lolcat
    pkgs.pwgen
  ];
}
