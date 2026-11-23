{ pkgs, ... }:
{
  home.packages = [
    # Git tools
    pkgs.glab

    # Build tools
    pkgs.gnumake
    pkgs.just

    # Common dev tools
    pkgs.delta
    pkgs.gettext
    pkgs.jless
    pkgs.jq
    pkgs.libxml2
    pkgs.yq

    # C
    pkgs.gcc

    # Golang
    pkgs.go

    # Java
    pkgs.openjdk
    pkgs.maven

    # Java Script
    pkgs.nodejs
    pkgs.yarn

    # Nix
    pkgs.nix-diff
    pkgs.nix-fast-build
    pkgs.nixfmt-tree
    pkgs.nvd

    # Python
    (pkgs.python3.withPackages (ps: [
      ps.pip
      ps.virtualenv
    ]))
  ];
}
