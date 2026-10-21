{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rtucek.tmuxinator;
  yamlFormat = pkgs.formats.yaml { };
in
{
  options.rtucek.tmuxinator = {
    projects = lib.mkOption {
      type = lib.types.attrsOf yamlFormat.type;
      default = { };
    };
  };

  config = {
    home-manager.users.rtucek.programs.tmux.tmuxinator.projects = cfg.projects;
  };
}
