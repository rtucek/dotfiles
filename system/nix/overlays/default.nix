{ ... }:
{
  nixpkgs.overlays = [
    (import ./tmuxinator.nix)
  ];
}
