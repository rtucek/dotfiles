{ self, inputs, ... }:
{
  flake.nixosConfigurations =
    let
      sys = "${self}/system";
      inherit (import sys) laptop;

      specialArgs = { inherit inputs self; };
    in
    {
      qemu-nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules = laptop ++ [
          ./qemu-nixos-btw
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
}
