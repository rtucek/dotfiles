{ config, lib, ... }:
let
  cfg = config.rtucek.git;
in
{
  options.rtucek.git = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Rudolf Tucek";
        description = "Sets `user.name` in the global git config";
      };

      email = lib.mkOption {
        type = lib.types.str;
        default = "tucek.rudolf@gmail.com";
        description = "Sets `user.email` in the global git config";
      };
    };

    gpg.signingKey = lib.mkOption {
      type = lib.types.str;
      default = "0x49593BD010DE4723";
      description = ''
        If string length is > 0, sets `user.signingKey` as well as various signing-related
        configuration in git's global config.
      '';
    };
  };

  config = {
    home-manager.users.rtucek.programs.git = {
      settings = {
        user = {
          name = cfg.user.name;
          email = cfg.user.email;
        };

        tag = {
          forceSignAnnotated = cfg.gpg.signingKey != "";
        };
      };

      signing =
        if cfg.gpg.signingKey == "" then
          {
            signByDefault = false;
          }
        else
          {
            format = "openpgp";
            key = cfg.gpg.signingKey;
            signByDefault = true;
          };
    };
  };
}
