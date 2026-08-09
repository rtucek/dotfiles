{ pkgs, ... }:
{
  home.packages = [
    # Git tools
    pkgs.glab

    # Common tools
    pkgs.delta
    pkgs.jless
    pkgs.jq

    # Golang
    pkgs.go

    # Nix
    pkgs.nix-diff
    pkgs.nvd
    pkgs.nixfmt-tree
  ];
}
