{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "config.d/*" ];
    settings = {
      "*" = {
        SetEnv = {
          TERM = "xterm-256color";
        };
      };
    };
  };
}
