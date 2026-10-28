{ pkgs, ... }:
{
  home.packages = [
    # digital ocean cli
    pkgs.doctl
  ];
}
