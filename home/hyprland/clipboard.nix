{ pkgs, ... }:
{
  home.packages = [
    pkgs.cliphist
  ];

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
