{ pkgs, ... }:
{
  home.packages = [
    pkgs.hyprpolkitagent
  ];

  services.hyprpolkitagent = {
    enable = true;
  };
}
