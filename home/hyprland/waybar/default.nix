{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.waybar
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        ###########################
        ## default config
        ###########################
        layer = "top";
        position = "top";
        height = 42;
        spacing = 4;
        mode = "dock";
        exclusive = true;
        gtk-layer-shell = true;
        passthrough = false;
        fixed-center = true;

        ###########################
        ## layout
        ###########################
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "idle_inhibitor"
          "clock"
          "hyprland/language"
          # "custom/capslock"
          "privacy"
          "systemd-failed-units"
        ];
        modules-right = [
          "bluetooth"
          "custom/vpn"
          "network#wifi"
          "network#ethernet"
          "battery"
          "group/settings"
          "cpu"
          "memory"
          "temperature"
          "disk"
          "tray"
          "custom/power-buttons"
        ];

        ###########################
        ## groups
        ###########################

        # See https://github.com/Alexays/Waybar/wiki/Module:-Group
        "group/settings" = {
          orientation = "horizontal";
          modules = [
            "wireplumber"
            "backlight"
          ];
          drawer = {
            transition-duration = 500;
            transition-left-to-right = false;
            click-to-reveal = false;
          };
        };

        ###########################
        ## custom
        ###########################

        # See https://github.com/Alexays/Waybar/wiki/Module:-Custom
        # TODO: add script
        # "custom/capslock" = {
        #   exec = "~/bin/capslock-check.sh";
        #   restart-interval = 1;
        #   return-type = "json";
        #   format = "{}";
        # };
        "custom/power-buttons" = {
          format = "⏻";
          tooltip = false;
          menu = "on-click";
          menu-file = ./power-menu.xml;
          menu-actions = {
            lock = "${lib.getBin pkgs.systemd}/bin/loginctl lock-session";
            logout = "${lib.getExe pkgs.hyprshutdown}";
            reboot = "${lib.getBin pkgs.systemd}/bin/systemctl reboot";
            shutdown = "${lib.getBin pkgs.systemd}/bin/systemctl poweroff";
            suspend = "${lib.getBin pkgs.systemd}/bin/systemctl suspend";
          };
        };
        # TODO: add script
        # "custom/vpn" = {
        #   format = "{}";
        #   exec = "~/bin/nmcli-active-vpn-conn.sh";
        #   return-type = "json";
        #   interval = 3;
        # };

        ###########################
        ## modules
        ###########################

        # TODO: add script
        # backlight = {
        #   # see https://github.com/Alexays/Waybar/wiki/Module:-Backlight
        #   interval = 2;
        #   format = "{icon} {percent}%";
        #   format-icons = [
        #     "󰛩"
        #     "󱩎"
        #     "󱩏"
        #     "󱩐"
        #     "󱩑"
        #     "󱩒"
        #     "󱩓"
        #     "󱩔"
        #     "󱩕"
        #     "󱩖"
        #     "󰛨"
        #   ];
        #   scroll-step = 5;
        #   on-scroll-up = "~/bin/backlight.sh \"+5%\"";
        #   on-scroll-down = "~/bin/backlight.sh \"-5%\"";
        #   smooth-scrolling-threshold = 3;
        #   tooltip = false;
        # };

        battery = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Battery
          interval = 3;
          states = {
            warning = 20;
            critical = 10;
          };
          format-discharging = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-full = " {capacity}%";
          format-plugged = " {capacity}%";
          format-charging = " {capacity}%";
          tooltip = true;
          tooltip-format = "{timeTo}";
          max-length = 25;
        };

        bluetooth = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Bluetooth
          tooltip = true;
          format = "󰂯";
          tooltip-format = "{controller_address} is {status}";
          format-disabled = "󰂲";
          tooltip-format-disabled = "Bluetooth disabled ({controller_address})";
          format-off = "󰂲";
          tooltip-format-off = "Bluetooth off ({controller_address})";
          format-on = "󰂲";
          tooltip-format-on = "Bluetooth on ({controller_address})";
          format-connected = "󰂱 {num_connections}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\tBattery: {device_battery_percentage}%";
        };

        clock = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Clock
          interval = 1;
          format = "󰔠 {:%a, %Y-%m-%d %H:%M:%S}";
          # locale MUST be enabled
          locale = "de_AT.UTF-8";
          ## "timezone": "Europe/Vienna",
          ## "timezones": [
          ## 	"UTC",
          ## ],
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "left";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>CW{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            # TODO: figure out how to deal with duplicate keys...
            # "on-click-right"= "mode";
            # "on-scroll-up"= "tz_up";
            # "on-scroll-down"= "tz_down";
            # "on-scroll-up"= "shift_up";
            # "on-scroll-down"= "shift_down";
          };
        };

        cpu = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-CPU
          format = " {usage}%";
          tooltip = true;
          interval = 1;
        };

        disk = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Disk
          interval = 30;
          format = "󰋊 {percentage_used}%";
          path = "/";
          unit = "GB";
          tooltip = true;
          tooltip-format = "Free:\t\t{specific_free:0.2f} GB\t({percentage_free}%)\nUsed:\t\t{specific_used:0.2f} GB\t({percentage_used}%)\nTotal space:\t{specific_total:0.2f} GB";
        };

        "hyprland/language" = {
          format = "󰌌 {}";
          format-en = "en";
          format-de = "de";
          keyboard-name = "at-translated-set-2-keyboard";
          on-click = "${lib.getBin pkgs.hyprland}/bin/hyprctl switchxkblayout at-translated-set-2-keyboard next";
          on-scroll-up = "${lib.getBin pkgs.hyprland}/bin/hyprctl switchxkblayout at-translated-set-2-keyboard next";
          on-scroll-down = "${lib.getBin pkgs.hyprland}/bin/hyprctl switchxkblayout at-translated-set-2-keyboard prev";
        };

        "hyprland/workspaces" = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#workspaces
          active-only = true;
          on-click = "activate";
          format = "{id}";
          all-outputs = false;
          disable-scroll = false;
          # "active-only"= false;
        };

        "hyprland/window" = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#window
          format = "{title}";
          separate-outputs = true;
        };

        idle_inhibitor = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Idle-Inhibitor
          start-activated = false;
          # Deactivate automatically after 2h
          timeout = 120;
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
        };

        memory = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Memory
          interval = 10;
          format = " {used:0.1f}Gi";
          tooltip = true;
          tooltip-format = "Used:\t\t{used:0.1f}GiB ({percentage}%)\nAvailable:\t{avail:0.1f}GiB\nTotal:\t\t{total:0.1f}GiB";
        };

        "network#ethernet" = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Network
          interface = "";
          interval = 5;
          tooltip = true;
          format-ethernet = "󰈁";
          tooltip-format-ethernet = "IP:\t\t{ipaddr}/{cidr}\nBandwith:\t {bandwidthDownBits} /  {bandwidthUpBits}\nInterface:\t{ifname}";
          format-disabled = "󰈂";
          tooltip-format-disabled = "{ifname} is disabled";
          format-linked = "󰈂";
          tooltip-format-linked = "{ifname} is linked";
          # Do not show, when not connected at all
          format-disconnected = "";
          # "tooltip-format-disconnected"= "{ifname} is not connected";
          format = ""; # do not show for any other states, except for those specified above
          # "tooltip-format"= "";
        };

        "network#wifi" = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Network
          interface = "";
          interval = 5;
          tooltip = true;
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          format-wifi = "{icon} {signalStrength}%";
          tooltip-format-wifi = "SSID:\t\t{essid}\nIP:\t\t{ipaddr}/{cidr}\nFrequency:\t{frequency} GHz\nBandwith:\t {bandwidthDownBits} /  {bandwidthUpBits}\nInterface:\t{ifname}";
          format-disabled = "󰤫";
          tooltip-format-disabled = "{ifname} is disabled";
          format-linked = "󱛇";
          tooltip-format-linked = "{ifname} is linked";
          format-disconnected = "󰤮";
          tooltip-format-disconnected = "{ifname} is not connected";
        };

        privacy = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Privacy
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          expand = true;
          ignore-monitor = false;
          modules = [
            {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            # {
            #   "type"= "audio-out";
            #   "tooltip"= true;
            #   "tooltip-icon-size"= 24;
            # }
            {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 24;
            }
            # # Example for ignore object:
            # {
            #   "type"= "audio-in";
            #   "name"= "cava";
            # }
          ];
          ignore = [ ];
        };

        systemd-failed-units = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Systemd-failed-units
          hide-on-ok = true;
          format = " {nr_failed}";
          system = true;
          user = true;
        };

        temperature = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Temperature
          # Leave commented out as the module will pick sensitive defaults
          # "thermal-zone"= 2;
          # Leave commented out as the module will pick sensitive defaults
          # "hwmon-path"= "/sys/class/hwmon/hwmon2/temp1_input";
          format-icons = [
            ""
            ""
            ""
          ];
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-critical = "{temperatureC}°C {icon}";
          tooltip = true;
          tooltip-format = "{temperatureC}°C";
        };

        tray = {
          # see https://github.com/Alexays/Waybar/wiki/Module:-Tray
          show-passive-items = true;
          spacing = 10;
        };

        # TODO: add script + wireplumber
        # wireplumber = {
        #   # see https://github.com/Alexays/Waybar/wiki/Module:-WirePlumber
        #   format = "{icon} {volume}%";
        #   format-muted = "󰖁";
        #   format-icons = [
        #     "󰕿"
        #     "󰖀"
        #     "󰕾"
        #   ];
        #   on-scroll-up = "~/bin/sound.sh \"volume\" \"+5%\"";
        #   on-scroll-down = "~/bin/sound.sh \"volume\" \"-5%\"";
        #   on-click = "~/bin/sound.sh \"mute\" \"toggle\"";
        #   on-click-middle = "helvum";
        #   scroll-step = 5;
        #   max-volume = 100;
        #   tooltip = true;
        #   tooltip-format = "Volume:\t{volume}%\nNode:\t{node_name}";
        #   smooth-scrolling-threshold = 3;
        #   node-type = "Audio/Sink";
        # };

      }
    ];

    style = builtins.readFile ./style.css;
  };
}
