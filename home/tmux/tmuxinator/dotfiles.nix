{
  pkgs,
  config,
  lib,
  ...
}:
let
  targetDir = "${config.home.homeDirectory}/projects/dotfiles";
  clone-dotfiles = "${
    import ../../scripts/clone-dotfiles.nix {
      inherit
        pkgs
        lib
        config
        targetDir
        ;
    }
  }/bin/clone-dotfiles.sh";
in
{
  systemd.user.services.clone-dotfiles = {
    Unit = {
      Description = "Clone dotfiles repo";
      Wants = "NetworkManager-wait-online.service";
      After = "NetworkManager-wait-online.service";
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "%h";
      ExecStart = clone-dotfiles;
    };
  };

  programs.tmux.tmuxinator.projects = {
    dotfiles = {
      name = "dotfiles";
      root = "${targetDir}/";

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
