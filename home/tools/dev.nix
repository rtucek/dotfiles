{ pkgs, ... }:
{
  home.packages = [
    # Common tools
    pkgs.delta
    pkgs.jless
    pkgs.jq

    # Golang
    pkgs.go

    # Nix
    pkgs.nix-diff
    pkgs.nixfmt-tree
  ];
}
