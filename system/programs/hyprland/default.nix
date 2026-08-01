{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.hyprland
    # For adwaita cursor theme
    pkgs.adwaita-icon-theme
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
