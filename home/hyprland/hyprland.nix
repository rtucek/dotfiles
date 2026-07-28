{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland =
    let
      # Mod key
      MOD = "ALT";
    in
    {
      enable = true;
      xwayland.enable = true;

      systemd.enable = true;
      systemd.variables = [ "--all" ];

      configType = "lua";
      settings =
        let
          # Paths to binaries
          backlight = "${import ../scripts/backlight.nix { inherit pkgs lib; }}/bin/backlight.sh";
          date = "${lib.getBin pkgs.coreutils-full}/bin/date";
          fileManager = "${lib.getExe pkgs.pcmanfm}";
          filemanager-cli = "${lib.getExe pkgs.yazi}";
          grimblast = "${lib.getExe pkgs.grimblast}";
          logout = "${lib.getExe pkgs.hyprshutdown}";
          menu = "${lib.getExe pkgs.rofi}";
          playerctl = "${lib.getExe pkgs.playerctl}";
          rfkill-toggle = "${import ../scripts/rfkill-toggle.nix { inherit pkgs lib; }}/bin/rfkill-toggle.sh";
          sound = "${import ../scripts/sound.nix { inherit pkgs lib; }}/bin/sound.sh";
          terminal = "${lib.getExe pkgs.kitty}";
          xdg-user-dirs = "${lib.getBin pkgs.xdg-user-dirs}/bin/xdg-user-dir";

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

          # mod = {
          #   _var = "ALT";
          # };

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
            no_update_news = true;
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
                "${MOD} + Q"
                (mkLuaInline "hl.dsp.exec_cmd('${terminal}')")
              ];
            }
            {
              _args = [
                "${MOD} + C"
                (mkLuaInline "hl.dsp.window.close()")
              ];
            }
            {
              _args = [
                "${MOD}  + M"
                (mkLuaInline "hl.dsp.exec_cmd('${logout}')")
              ];
            }
            {
              _args = [
                "${MOD} + E"
                (mkLuaInline "hl.dsp.exec_cmd('${fileManager}')")
              ];
            }
            {
              _args = [
                "${MOD} + SHIFT + E"
                (mkLuaInline "hl.dsp.exec_cmd('${terminal} ${filemanager-cli}')")
              ];
            }
            {
              _args = [
                "${MOD} + V"
                (mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
              ];
            }
            {
              _args = [
                "${MOD} + R"
                (mkLuaInline "hl.dsp.exec_cmd('${menu} -show drun -drun-show-actions')")
              ];
            }
            {
              _args = [
                "${MOD} + P"
                (mkLuaInline "hl.dsp.window.pseudo()")
              ];
            }
            {
              _args = [
                "${MOD} + J"
                (mkLuaInline "hl.dsp.layout(\"togglesplit\")")
              ];
            }
            {
              _args = [
                "${MOD} + F"
                (mkLuaInline "hl.dsp.window.fullscreen({ [\"mode\"] = \"maximized\" })")
              ];
            }

            # Move focus with main mod + arrow keys
            {
              _args = [
                "${MOD} + left"
                (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"l\" })")
              ];
            }
            {
              _args = [
                "${MOD} + right"
                (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"r\" })")
              ];
            }
            {
              _args = [
                "${MOD} + up"
                (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"u\" })")
              ];
            }
            {
              _args = [
                "${MOD} + down"
                (mkLuaInline "hl.dsp.focus({ [\"direction\"] = \"d\" })")
              ];
            }

            # Special workspace (aka scratchpad)
            {
              _args = [
                "${MOD} + S"
                (mkLuaInline "hl.dsp.workspace.toggle_special(\"magic\")")
              ];
            }
            {
              _args = [
                "${MOD} + SHIFT + S"
                (mkLuaInline "hl.dsp.workspace.move({ [\"workspace\"] = \"special:magic\", [\"monitor\"] = \"current\" })")
              ];
            }

            # Scroll through existing workspaces with mod + scroll
            {
              _args = [
                "${MOD} + mouse_down"
                (mkLuaInline "hl.dsp.focus({ [\"workspace\"] = \"m+1\" })")
              ];
            }
            {
              _args = [
                "${MOD} + mouse_up"
                (mkLuaInline "hl.dsp.focus({ [\"workspace\"] = \"m-1\" })")
              ];
            }

            # Move/resize windows with mod + LMB/RMB and dragging
            {
              _args = [
                "${MOD} + mouse:272"
                (mkLuaInline "hl.dsp.window.drag()")
                { mouse = true; }
              ];
            }
            {
              _args = [
                "${MOD} + mouse:273"
                (mkLuaInline "hl.dsp.window.resize()")
                { mouse = true; }
              ];
            }

            # Multimedia keys
            {
              _args = [
                "XF86AudioRaiseVolume"
                (mkLuaInline "hl.dsp.exec_cmd(\"${sound} volume '+5%'\")")
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioLowerVolume"
                (mkLuaInline "hl.dsp.exec_cmd(\"${sound} volume '-5%'\")")
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86AudioMute"
                (mkLuaInline "hl.dsp.exec_cmd(\"${sound} mute toggle\")")
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
                (mkLuaInline "hl.dsp.exec_cmd(\"${backlight} '+5%'\")")
                {
                  locked = true;
                  repeating = true;
                }
              ];
            }
            {
              _args = [
                "XF86MonBrightnessDown"
                (mkLuaInline "hl.dsp.exec_cmd(\"${backlight} '-5%'\")")
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
                (mkLuaInline "hl.dsp.exec_cmd(\"${playerctl} 'next'\")")
                { locked = true; }
              ];
            }
            {
              _args = [
                "XF86AudioPrev"
                (mkLuaInline "hl.dsp.exec_cmd(\"${playerctl} 'previous'\")")
                { locked = true; }
              ];
            }
            {
              _args = [
                "XF86AudioPlay"
                (mkLuaInline "hl.dsp.exec_cmd(\"${playerctl} 'play-pause'\")")
                { locked = true; }
              ];
            }
            {
              _args = [
                "XF86AudioPause"
                (mkLuaInline "hl.dsp.exec_cmd(\"${playerctl} 'play-pause'\")")
                { locked = true; }
              ];
            }

            # Screenshots
            {
              _args = [
                "Print"
                (mkLuaInline "hl.dsp.exec_cmd('${grimblast} --notify save area \"$(${xdg-user-dirs} PICTURES)/$(${date} --utc \\'+%F_%H.%M.%S\\').png')")
                { locked = true; }
              ];
            }
            {
              _args = [
                "${MOD} + Print"
                (mkLuaInline "hl.dsp.exec_cmd('${grimblast} --notify copy area')")
                { locked = true; }
              ];
            }
            {
              _args = [
                "CTRL + Print"
                (mkLuaInline "hl.dsp.exec_cmd('${grimblast} --notify save active \"$(${xdg-user-dirs} PICTURES)/$(${date} --utc \\'+%F_%H.%M.%S\\').png')")
                { locked = true; }
              ];
            }
            {
              _args = [
                "${MOD} + CTRL + Print"
                (mkLuaInline "hl.dsp.exec_cmd('${grimblast} --notify copy active')")
                { locked = true; }
              ];
            }

            # Other XF86 key bindings
            {
              _args = [
                "XF86RFKill"
                (mkLuaInline "hl.dsp.exec_cmd('${rfkill-toggle}')")
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
            hl.bind("${MOD} + " .. key, hl.dsp.focus({ ["workspace"] = i}))

            -- Move active window to a workspace with mod + SHIFT + [0-9]
            hl.bind("${MOD} + SHIFT + " .. key, hl.dsp.window.move({ ["workspace"] = i }))

            -- Move active window to a workspace with mod + SHIFT + [0-9]
            hl.bind("${MOD} + CTRL + SHIFT + " .. key, hl.dsp.window.move({ ["workspace"] = i, ["follow"] = false }))
        end
      '';
    };
}
