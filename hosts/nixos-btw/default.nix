{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  networking.hostName = "nixos-btw";
}
