{ ... }:
{
  nixpkgs.overlays = [
    (import ./doctl.nix)
    (import ./tmuxinator.nix)
  ];
}
