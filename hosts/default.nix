{ self, inputs, ... }:
{
  flake.nixosConfigurations =
    let
      sys = "${self}/system";
      inherit (import sys) laptop;

      hmModules = [
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
      ];

      commonCfg = hmModules ++ [
        ./common
      ];

      specialArgs = { inherit inputs self; };
    in
    {
      qemu-nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules =
          laptop
          ++ commonCfg
          ++ [
            ./qemu-nixos-btw
          ];
      };
    };
}
