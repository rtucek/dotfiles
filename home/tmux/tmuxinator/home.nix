{ pkgs, lib, ... }:
{
  programs.tmux.tmuxinator.projects = {
    home = {
      name = "home";
      root = "~/";

      startup_window = "cli";

      windows =
        let
          htop = "${lib.getExe pkgs.htop}";
          btop = "${lib.getExe pkgs.btop}";
          fastfetch = "${lib.getExe pkgs.fastfetch}";
        in
        [
          {
            htop = htop;
          }
          {
            btop = btop;
          }
          {
            cli = fastfetch;
          }
        ];
    };
  };
}
