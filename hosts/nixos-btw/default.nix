{ inputs, home-manager, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.rtucek = ./home.nix;
  };

  networking.hostName = "nixos-btw";

  security.pam.services.hyprlock = {
    enable = true;
  };
}
