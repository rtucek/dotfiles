{ pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = {
        monitor = "";
        path = toString ./screensaver.jpeg;
        fit_mode = "cover";
      };
    };
  };
}
