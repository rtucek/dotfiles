{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.nixos-container
  ];

  virtualisation.containers = {
    enable = true;
  };
}
