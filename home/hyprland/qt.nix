{ pkgs, ... }:
{
  home.packages = [
    # Proper Qt support for wayland
    # See https://wiki.hypr.land/Useful-Utilities/Must-have/#qt-wayland-support
    pkgs.qt6.qtwayland
    pkgs.libsForQt5.qt5.qtwayland
    # QML Style for Qt6 apps
    # See https://wiki.hypr.land/Hypr-Ecosystem/hyprland-qt-support/
    pkgs.hyprland-qt-support
  ];
}
