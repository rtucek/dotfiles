{
  pkgs,
  lib,
  config,
  targetDir,
  ...
}:
let
  targetDir = "${config.home.homeDirectory}/projects/dotfiles";
  repoUrl = "https://github.com/rtucek/dotfiles.git";
  git = "${lib.getExe pkgs.git}";
  mkdir = "${lib.getBin pkgs.coreutils-full}/bin/mkdir";
in
pkgs.writeShellScriptBin "clone-dotfiles.sh" ''
  # Only clone if the .git directory doesn\'t exist
  # This preserves local changes if the repo already exists
  if [ ! -d "${targetDir}/.git" ]; then
    ${mkdir} -p ${targetDir}
    ${git} clone ${repoUrl} ${targetDir}
  fi
''
