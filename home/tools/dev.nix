{ pkgs, ... }:
{
  home.packages = [
    # Git tools
    pkgs.glab

    # Common tools
    pkgs.delta
    pkgs.jless
    pkgs.jq
    pkgs.libxml2

    # Golang
    pkgs.go

    # Java
    pkgs.openjdk
    pkgs.maven

    # Nix
    pkgs.nix-diff
    pkgs.nvd
    pkgs.nixfmt-tree
  ];
}
