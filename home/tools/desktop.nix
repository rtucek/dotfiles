{ pkgs, ... }:
{
  home.packages = [
    # CLI & terminal
    pkgs.wl-clipboard
    pkgs.kitty

    # Encryption
    pkgs.veracrypt

    # Sound
    pkgs.hyprpwcenter

    # Office
    pkgs.libreoffice

    # HTTP client
    pkgs.postman
  ];

  programs = {
    thunderbird = {
      enable = true;
      languagePacks = [
        "en-US"
        "de"
      ];
    };
  };
}
