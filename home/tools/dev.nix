{ config, pkgs, ... }:
{
  home.packages = [
    # Git tools
    pkgs.glab

    # Build tools
    pkgs.gnumake
    pkgs.just

    # Common dev tools
    pkgs.delta
    pkgs.jless
    pkgs.jq
    pkgs.libxml2

    # C
    pkgs.gcc

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

  # Add ~/go/bin to $PATH
  home.sessionPath = [
    "${config.home.homeDirectory}/go/bin"
  ];
}
