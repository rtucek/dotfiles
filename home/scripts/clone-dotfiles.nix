{
  pkgs,
  lib,
  targetDir,
  ...
}:
let
  repoUrl = "https://github.com/rtucek/dotfiles.git";
  git = "${lib.getExe pkgs.git}";
  mkdir = "${lib.getBin pkgs.coreutils-full}/bin/mkdir";
in
pkgs.writeShellScriptBin "clone-dotfiles.sh" ''
  # Only clone if the .git directory doesn't exist
  # This preserves local changes if the repo already exists
  if [ -d "${targetDir}/.git" ]; then
    echo "dotfiles repostiory already exists"

    exit 0
  fi

  echo "cloning dotfiles repository"
  ${mkdir} -p ${targetDir}
  ${git} clone ${repoUrl} ${targetDir}
''
