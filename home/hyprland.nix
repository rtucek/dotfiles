{ lib, pkgs, ... }:
{
  home.packages = [
    pkgs.kitty
    pkgs.pcmanfm
    pkgs.rofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd.enable = true;
    systemd.variables = [ "--all" ];

    configType = "lua";
    settings = with lib.generators; {
      ########################
      ## VARS
      ########################

      mod = {
        _var = "ALT";
      };

      terminal = {
        _var = "${lib.getExe pkgs.kitty}";
      };

      fileManager = {
        _var = "${lib.getExe pkgs.pcmanfm}";
      };

      menu = {
        _var = "${lib.getExe pkgs.rofi} -show drun -drun-show-actions";
      };

      ########################
      ## Monitors
      ########################

      # See https://wiki.hypr.land/Configuring/Basics/Monitors/
      monitor = [
        {
          # Sensitive default for arbitrary new monitors
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hypr.land/Configuring/Environment-variables/
      env = [
        {
          _args = [
            "XCURSOR_SIZE"
            "24"
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            "24"
          ];
        }
      ];

      ###################
      ### PERMISSIONS ###
      ###################

      # See https://wiki.hypr.land/Configuring/Basics/Variables/#ecosystem
      config.ecosystem = {
        no_update_news = false;
        no_donation_nag = true;
        # enforce_permissions = true;
      };

      #####################
      ### LOOK AND FEEL ###
      #####################

      # See https://wiki.hypr.land/Configuring/Basics/Variables/#general
      config.general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        col.active_border = {
          colors = [
            "rgba(33ccffee)"
            "rgba(00ff99ee)"
          ];
          angle = 45;
        };
        col.inactive_border = {
          colors = [ "rgba(595959aa)" ];
        };

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true;

        # See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
        allow_tearing = false;

        layout = "dwindle";
      };

      # See https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
      config.decoration = {
        rounding = 10;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        # See https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # See https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # See https://wiki.hypr.land/Configuring/Basics/Variables/#animations
      # as well as https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
      config.animations = {
        enabled = true;
      };
      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1
                ]
                [
                  0.32
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            {
              type = "bezier";
              points = [
                [
                  0.65
                  0.05
                ]
                [
                  0.36
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0
                  0
                ]
                [
                  1
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = [
                [
                  0.5
                  0.5
                ]
                [
                  0.75
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = [
                [
                  0.15
                  0
                ]
                [
                  0.1
                  1
                ]
              ];
            }
          ];
        }
      ];
      animation = [
        {
          leaf = "global";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 5.39;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windows";
          enabled = true;
          speed = 4.79;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 4.1;
          bezier = "easeOutQuint";
          stye = "popin 87%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 1.49;
          bezier = "linear";
          style = "popin 87%";
        }
        {
          leaf = "fadeIn";
          enabled = true;
          speed = 1.73;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 1.46;
          bezier = "almostLinear";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 3.03;
          bezier = "quick";
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 3.81;
          bezier = "easeOutQuint";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 4;
          bezier = "easeOutQuint";
          style = "fade";
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 1.5;
          bezier = "linear";
          style = "fade";
        }
        {
          leaf = "fadeLayersIn";
          enabled = true;
          speed = 1.79;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeLayersOut";
          enabled = true;
          speed = 1.39;
          bezier = "almostLinear";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesIn";
          enabled = true;
          speed = 1.21;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesOut";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
      ];

      # Smart gaps
      # See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#smart-gaps
      workspace_rule = [
        {
          workspace = "w[tv1]";
          gaps_out = 0;
          gaps_in = 0;
        }
        {
          workspace = "f[1]";
          gaps_out = 0;
          gaps_in = 0;
        }
      ];
      window_rule = [
        {
          match = {
            float = false;
            workspace = "w[tv1]";
          };
          border_size = 0;
          rounding = 0;
        }
        {
          match = {
            float = false;
            workspace = "f[1]";
          };
          border_size = 0;
          rounding = 0;
        }
      ];

      # Dwindle Layout
      # See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
      config.dwindle.preserve_split = true;

      # Master Layout
      # See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
      config.master.new_status = "master";

      # Scrolling Layout
      # See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
      config.scrolling.fullscreen_on_one_column = true;

      # Get rid of default wallpaper
      config.misc = {
        force_default_wallpaper = false;
        disable_hyprland_logo = true;
      };
    };
  };
}
