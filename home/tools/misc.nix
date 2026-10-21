{ pkgs, ... }:
{
  home.packages = [
    pkgs.cowsay
    pkgs.fastfetch
    pkgs.fortune
    pkgs.gimp
    pkgs.gitlogue
    pkgs.lolcat
    pkgs.pwgen
  ];
}
