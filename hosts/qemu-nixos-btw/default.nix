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
  sops.defaultSopsFile = ../../secrets/hosts/qemu-nixos-btw.yaml;

  security.pam.services.hyprlock = {
    enable = true;
  };
}
