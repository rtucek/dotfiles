{
  inputs,
  home-manager,
  ...
}:
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

  networking.hostName = "qemu-nixos-btw";

  security.pam.services.hyprlock = {
    enable = true;
  };
}
