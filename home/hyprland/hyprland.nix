{ lib, pkgs, ... }:
{
  home.packages = [
    pkgs.hyprshutdown
    pkgs.kitty
    pkgs.pcmanfm
    pkgs.rofi
    pkgs.yazi
    pkgs.playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    systemd.enable = true;
    systemd.variables = [ "--all" ];

    configType = "lua";
    settings =
      let
        sound = "${import ../scripts/sound.nix { inherit pkgs lib; }}/bin/sound.sh";
        backlight = "${import ../scripts/backlight.nix { inherit pkgs lib; }}/bin/backlight.sh";
        rfkill-toggle = "${import ../scripts/rfkill-toggle.nix { inherit pkgs lib; }}/bin/rfkill-toggle.sh";

        # Smart gaps
        # See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#smart-gaps
        smart-gaps = {
          workspace-rule = [
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
          window-rule = [
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
        };
      in
      with lib.generators;
      {
        ########################
        ## VARS
        ########################

        mod = {
          _var = "ALT";
        };

        backlight = {
          _var = "${backlight}";
        };

        fileManager = {
          _var = "${lib.getExe pkgs.pcmanfm}";
        };

        fileManagerCli = {
          _var = "${lib.getExe pkgs.yazi}";
        };

        menu = {
          _var = "${lib.getExe pkgs.rofi} -show drun -drun-show-actions";
        };

        playerctl = {
          _var = "${lib.getExe pkgs.playerctl}";
        };

        rfkillToggle = {
          _var = "${rfkill-toggle}";
        };

        shutdown = {
          _var = "${lib.getExe pkgs.hyprshutdown}";
        };

        sound = {
          _var = "${sound}";
        };

        terminal = {
          _var = "${lib.getExe pkgs.kitty}";
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

        #############
        ### INPUT ###
        #############

        # See https://wiki.hypr.land/Configuring/Basics/Variables/#input
        config.input = {
          kb_layout = "us,de";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = true;

          sensitivity = 0; # between -1.0 and 1.0; 0 means no modification.

          touchpad.natural_scroll = true;
        };

        # See https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
        config.gesture = [
          {
            fingers = 3;
            direction = "horizontal";
            action = "workspace";
          }
        ];

        #####################
        #### KEYBINDINGS ####
        #####################

        # See https://wiki.hypr.land/Configuring/Basics/Binds/

        bind = [
          # Common bindings
          {
            _args = [
              (mkLuaInline "mod .. \" + Q\"")
              (mkLuaInline "hl.dsp.exec_cmd(terminal)")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + C\"")
              (mkLuaInline "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + M\"")
              (mkLuaInline "hl.dsp.exec_cmd(shutdown)")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + E\"")
              (mkLuaInline "hl.dsp.exec_cmd(fileManager)")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + SHIFT + E\"")
              (mkLuaInline "hl.dsp.exec_cmd(terminal .. \" \" .. fileManagerCli)")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + V\"")
              (mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + R\"")
              (mkLuaInline "hl.dsp.exec_cmd(menu)")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + P\"")
              (mkLuaInline "hl.dsp.window.pseudo()")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + J\"")
              (mkLuaInline "hl.dsp.layout(\"togglesplit\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + F\"")
              (mkLuaInline "hl.dsp.window.fullscreen({ [\"mode\"] = \"maximized\" })")
            ];
          }

          # Move focus with main mod + arrow keys
          {
            _args = [
              (mkLuaInline "mod .. \" + left\"")
              (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"l\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + right\"")
              (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"r\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + up\"")
              (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"u\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + down\"")
              (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"d\" })")
            ];
          }

          # Special workspace (aka scratchpad)
          {
            _args = [
              (mkLuaInline "mod .. \" + S\"")
              (mkLuaInline "hl.dsp.workspace.toggle_special(\"magic\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + SHIFT + S\"")
              (mkLuaInline "hl.dsp.workspace.move({ [\"workspace\"] = \"special:magic\", [\"monitor\"] = \"current\" })")
            ];
          }

          # Scroll through existing workspaces with mod + scroll
          {
            _args = [
              (mkLuaInline "mod .. \" + mouse_down\"")
              (mkLuaInline "hl.dsp.focus({ [\"workspace\"] = \"m+1\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + mouse_up\"")
              (mkLuaInline "hl.dsp.focus({ [\"workspace\"] = \"m-1\" })")
            ];
          }

          # Move/resize windows with mod + LMB/RMB and dragging
          {
            _args = [
              (mkLuaInline "mod .. \" + mouse:272\"")
              (mkLuaInline "hl.dsp.window.drag()")
              { mouse = true; }
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + mouse:273\"")
              (mkLuaInline "hl.dsp.window.resize()")
              { mouse = true; }
            ];
          }

          # Multimedia keys
          {
            _args = [
              "XF86AudioRaiseVolume"
              (mkLuaInline "hl.dsp.exec_cmd(sound .. \" \\\"volume\\\" \\\"+5%\\\"\")")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioLowerVolume"
              (mkLuaInline "hl.dsp.exec_cmd(sound .. \" \\\"volume\\\" \\\"-5%\\\"\")")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86AudioMute"
              (mkLuaInline "hl.dsp.exec_cmd(sound .. \" \\\"mute\\\" \\\"toggle\\\"\")")
              {
                locked = true;
                repeating = true;
              }
            ];
          }

          # Brightness control
          {
            _args = [
              "XF86MonBrightnessUp"
              (mkLuaInline "hl.dsp.exec_cmd(backlight .. \" \\\"+5%\\\"\")")
              {
                locked = true;
                repeating = true;
              }
            ];
          }
          {
            _args = [
              "XF86MonBrightnessDown"
              (mkLuaInline "hl.dsp.exec_cmd(backlight .. \" \\\"-5%\\\"\")")
              {
                locked = true;
                repeating = true;
              }
            ];
          }

          # Multimedia control
          {
            _args = [
              "XF86AudioNext"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" \\\"next\\\"\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPrev"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" \\\"previous\\\"\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPlay"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" \\\"play-pause\\\"\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPause"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" \\\"play-pause\\\"\")")
              { locked = true; }
            ];
          }

          # TODO: screenshots

          # Other XF86 key bindings
          {
            _args = [
              "XF86RFKill"
              (mkLuaInline "hl.dsp.exec_cmd(rfkillToggle)")
              { locked = true; }
            ];
          }
        ];

        ################################
        #### WINDOWS AND WORKSPACES ####
        ################################

        # See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
        # and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
        workspace_rule = smart-gaps.workspace-rule ++ [ ];
        window_rule = smart-gaps.window-rule ++ [
          # Suppress maximize request from all apps
          {
            name = "suppress-maximize-events";
            match = {
              class = ".*";
            };

            suppress_event = "maximize";
          }
          {
            name = "fix-xwayland-drags";
            match = {
              class = "^$";
              title = "^$";
              xwayland = true;
              float = true;
              fullscreen = false;
              pin = false;
            };

            no_focus = true;
          }
        ];
      };

    extraConfig = ''
      for i = 1, 10 do
          local key = i % 10 -- 10 maps to key 0

          -- Switch workspaces with mod + [0-9]
          hl.bind(mod .. " + " .. key, hl.dsp.focus({ ["workspace"] = i}))

          -- Move active window to a workspace with mod + SHIFT + [0-9]
          hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ ["workspace"] = i }))

          -- Move active window to a workspace with mod + SHIFT + [0-9]
          hl.bind(mod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ ["workspace"] = i, ["follow"] = false }))
      end
    '';
  };
}
