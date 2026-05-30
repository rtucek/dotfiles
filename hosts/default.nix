{ self, inputs, ... }:
{
  flake.nixosConfigurations =
    let
      sys = "${self}/system";
      inherit (import sys) laptop;

      specialArgs = { inherit inputs self; };
    in
    {
      nixos-btw = inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules = laptop ++ [
          ./nixos-btw
        ];
      };
    };
}
