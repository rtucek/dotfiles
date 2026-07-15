{
  pkgs,
  config,
  lib,
  ...
}:
let
  targetDir = "${config.home.homeDirectory}/projects/dotfiles";
  repoUrl = "https://github.com/rtucek/dotfiles.git";
  git = "${lib.getExe pkgs.git}";
  mkdir = "${lib.getBin pkgs.coreutils-full}/bin/mkdir";
in
{
  home.activation.cloneDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" "git" ] ''
    # Only clone if the .git directory doesn't exist
    # This preserves local changes if the repo already exists
    if [ ! -d "${targetDir}/.git" ]; then
      ${mkdir} -p ${targetDir}
      ${git} clone ${repoUrl} ${targetDir}
    fi
  '';

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
