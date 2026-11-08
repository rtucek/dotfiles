{ ... }:
{
  nixpkgs.overlays = [
    (import ./brave.nix)
    (import ./doctl.nix)
    (import ./tmuxinator.nix)
    (import ./tuxedo-drivers.nix)
  ];
}
