{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.postgresql
    pkgs.pgcli
  ];
}
