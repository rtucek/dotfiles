{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  # Require git for flakes
  environment.systemPackages = [
    pkgs.git
  ];

  nix =
    let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
    {
      # Pin the registry.
      # This avoids downloading and evaling a new nixpkgs version every time.
      registry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs;

      # Set the path for channels compat
      nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        flake-registry = "/etc/nix/registry.json";
      };
    };
}
