{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = lib.mkIf config.rtucek.virtualisation.containers.enable [
    pkgs.nixos-container
  ];

  virtualisation.containers.enable = config.rtucek.virtualisation.containers.enable;
}
