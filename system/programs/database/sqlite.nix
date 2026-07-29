{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.sqlite
    pkgs.litecli
  ];
}
