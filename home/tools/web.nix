{ pkgs, ... }:
{
  home.packages = [
    # Browsers
    pkgs.brave

    # CLI clients
    pkgs.curl
    pkgs.httpie
  ];
}
