{ pkgs, ... }:
{
  home.packages = [
    # General
    pkgs.openssl

    # Certificate inspection and management
    pkgs.certigo
    pkgs.testssl
    pkgs.mkcert
  ];
}
