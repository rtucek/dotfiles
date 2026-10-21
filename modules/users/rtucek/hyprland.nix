{ lib, config, ... }:
let
  cfg = config.rtucek.hyprland;

  typeMonitor = lib.types.submodule {
    options = {
      output = lib.mkOption {
        type = lib.types.str;
        description = ''
          Output name or desc:... description prefix
        '';
      };

      mode = lib.mkOption {
        type = lib.types.str;
        description = ''
          Resolution and refresh rate, e.g. 1920x1080@144
        '';
      };

      position = lib.mkOption {
        type = lib.types.str;
        default = "auto";
        description = ''
          Position in the virtual layout, e.g. 1920x0
        '';
      };

      scale = lib.mkOption {
        type = lib.types.oneOf [
          lib.types.float
          lib.types.int
          lib.types.str
        ];
        default = "auto";
        description = ''
          Scale factor, e.g. 1.5
        '';
      };

      disabled = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = ''
          Removes the monitor from the layout
        '';
      };
    };
  };
in
{
  options.rtucek.hyprland = {
    monitors = lib.mkOption {
      type = lib.types.listOf typeMonitor;
      default = [ ];
      description = ''
        List of monitor definitions.
      '';
    };
  };

  config = {
    home-manager.users.rtucek = {
      wayland.windowManager = {
        hyprland.settings = {
          monitor = cfg.monitors;
        };
      };
    };
  };
}
