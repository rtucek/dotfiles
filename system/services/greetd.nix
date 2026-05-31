{
  lib,
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = [
    pkgs.hyprland
    pkgs.regreet
  ];

  services.greetd =
    let
      session = {
        command = "${lib.getBin pkgs.hyprland}/bin/start-hyprland -- -c /etc/greetd/hyprland.lua";
        user = "greeter";
      };
    in
    {
      enable = true;
      restart = false;

      settings = {
        terminal.vt = 1;
        default_session = session;
      };
    };

  environment.etc = {
    "greetd/hyprland.lua" = {
      mode = "0644";
      text = ''
        hl.on("hyprland.start", function()
          hl.exec_cmd("${lib.getExe pkgs.regreet}; ${lib.getBin pkgs.hyprland}/bin/hyprctl dispatch 'hl.dsp.exit()'")
        end)
        hl.config({
          misc = {
            disable_hyprland_logo = true,
            disable_splash_rendering = true,
            disable_hyprland_guiutils_check = true,
          },
        })
      '';
    };
  };

  programs.regreet = {
    enable = true;
    settings = {
      commands = {
        reboot = [
          "systemctl"
          "reboot"
        ];
        poweroff = [
          "systemctl"
          "poweroff"
        ];
      };
    };
  };
}
