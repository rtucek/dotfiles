{ ... }:
{
  nixpkgs.overlays = [
    (import ./doctl.nix)
    (import ./nix-fast-build.nix)
    (import ./tmuxinator.nix)
    (import ./tuxedo-drivers.nix)
  ];
}
