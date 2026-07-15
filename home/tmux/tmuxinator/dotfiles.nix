{ pkgs, config, ... }:
{
  programs.tmux.tmuxinator.projects = {
    dotfiles = {
      name = "dotfiles";
      root = "~/projects/dotfiles/";

      startup_window = "git";

      windows =
        let
          nvim = "${config.programs.nixvim.build.package}/bin/nvim";
        in
        [
          {
            nvim = nvim;
          }
          {
            git = [
              ""
            ];
          }
        ];
    };
  };
}
