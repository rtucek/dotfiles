{ pkgs, ... }:
{
  home.packages = [
    pkgs.coreutils-full
    pkgs.htop
  ];
}
