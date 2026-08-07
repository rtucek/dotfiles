{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nvd
  ];
}
