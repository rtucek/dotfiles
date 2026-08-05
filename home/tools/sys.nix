{ pkgs, ... }:
{
  home.packages = [
    # Standard UNIX tools
    pkgs.coreutils-full

    # System management (local & remote)
    pkgs.efibootmgr
    pkgs.util-linux
    pkgs.openssh

    # System monitoring
    pkgs.btop
    pkgs.htop
    pkgs.inxi
    pkgs.lshw
    pkgs.pstree

    # Shells
    pkgs.bash
    pkgs.fish
  ];
}
