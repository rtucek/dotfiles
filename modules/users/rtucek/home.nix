{ lib, config, ... }:
let
  cfg = config.rtucek.home;
in
{
  options.rtucek.home = {
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "26.05";
      description = ''
        Home Manager's `home.stateVersion`.
      '';
    };

    sops.defaultSopsFile = lib.mkOption {
      type = lib.types.pathInStore;
      default = ../../../secrets/users/rtucek.yaml;
      description = ''
        Default encrypted SOPS file to be used by Home Manager.
      '';
    };
  };

  config = {
    # Home Manager configuration
    home-manager.users.rtucek = {
      imports = [
        ../../../home
      ];

      home = {
        stateVersion = cfg.stateVersion;
        username = "rtucek";
        homeDirectory = "/home/rtucek";
      };

      sops = {
        defaultSopsFile = cfg.sops.defaultSopsFile;
      };
    };
  };
}
