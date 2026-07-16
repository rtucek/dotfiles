{ pkgs, ... }:
{
  home.packages = [
    # CLI & terminal
    pkgs.wl-clipboard
    pkgs.kitty

    # Email
    pkgs.thunderbird

    # Encryption
    pkgs.veracrypt

    # Sound
    pkgs.hyprpwcenter

    # Office
    pkgs.libreoffice

    # HTTP client
    pkgs.postman
  ];
}
