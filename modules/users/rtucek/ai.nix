{ lib, config, ... }:
let
  cfg = config.rtucek.ai;
in
{
  options.rtucek.ai = {
    claude-code = {
      enable = lib.options.mkEnableOption "Enable claude-code";
    };
  };

  config = lib.mkIf cfg.claude-code.enable {
    home-manager.users.rtucek = {
      programs.claude-code = {
        enable = true;
        settings = {
          theme = "dark";
        };
      };
    };
  };
}
