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
      tux-ibp-amdgen9-nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules =
          laptop
          ++ commonCfg
          ++ [
            ./tux-ibp-amdgen9-nixos-btw
          ];
      };

      dell-prec-5570-nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules =
          laptop
          ++ commonCfg
          ++ [
            ./dell-prec-5570-nixos-btw
          ];
      };

      dell-xps9360-nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules =
          laptop
          ++ commonCfg
          ++ [
            ./dell-xps9360-nixos-btw
          ];
      };

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
