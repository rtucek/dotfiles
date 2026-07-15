{ pkgs, lib, ... }:
{
  programs.tmux.tmuxinator.projects = {
    home = {
      name = "home";
      root = "~/";

      windows =
        let
          htop = "${lib.getExe pkgs.htop}";
          fastfetch = "${lib.getExe pkgs.fastfetch}";
        in
        [
          {
            htop = htop;
          }
          {
            cli = fastfetch;
          }
        ];
    };
  };
}
