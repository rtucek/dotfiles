{ pkgs, ... }:
{
  home.packages = [
    pkgs.brightnessctl
    pkgs.hypridle
  ];

  services.hypridle = {
    enable = true;
    settings = {

      general = {
        # Avoid starting multiple hyprlock instances.
        lock_cmd = "pidof hyprlock || hyprlock";
        # Lock before suspend.
        before_sleep_cmd = "loginctl lock-session";
        # To avoid having to press a key twice to turn on the display.
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          # Dim screen
          timeout = 150;
          # Set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-timeout = "brightnessctl -s set 10";
          # Monitor backlight restore.
          on-resume = "brightnessctl -r";
        }
        {
          # Turn off keyboard backlight.
          timeout = 150;
          # Turn off keyboard backlight.
          on-timeout = "brightnessctl -sd chromeos::kbd_backlight set 1";
          # Turn on keyboard backlight.
          on-resume = "brightnessctl -rd chromeos::kbd_backlight";
        }
        {
          # Lock screen
          timeout = 300;
          # Lock screen when timeout has passe
          on-timeout = "loginctl lock-session";
        }
        {
          # Turn off screen
          timeout = 450;
          # Screen off when timeout has passed
          on-timeout = "hyprctl dispatch dpms off";
          # Screen on when activity is detected after timeout has fired.
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          # Suspend the machine
          timeout = 600;
          # Suspend pc
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
