{ lib, ... }:
{
  # to be generated via nixos-anywhere
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
