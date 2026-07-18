{ pkgs, ... }:
{
  home.packages = [
    # General
    pkgs.openssl

    # Certificate inspection and management
    pkgs.certigo
    pkgs.testssl
    pkgs.mkcert

    # Secret management
    pkgs.age
    pkgs.keepassxc
    pkgs.lastpass-cli
    pkgs.sops
  ];
}
