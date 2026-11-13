{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.rtucek;
in
{
  options.rtucek = {
    defaultShell = lib.options.mkOption {
      type =
        let
          inherit (lib) types;
        in
        types.nullOr (types.either types.shellPackage (types.passwdEntry types.path));
      default = pkgs.fish;
      description = ''
        Default shell to be used.
      '';
    };

    defaultGroups = lib.options.mkOption {
      type =
        let
          inherit (lib) types;
        in
        types.listOf types.str;
      default = [
        "wheel" # sudo make me a sandwich
        "docker" # run docker commands without sudo
        "networkmanager" # allow managing connections without sudo
      ];
      description = ''
        Unix groups, to which the user shall be added.
      '';
    };

    defaultAuthorizedSshKeys = lib.options.mkOption {
      type =
        let
          inherit (lib) types;
        in
        types.listOf types.str;
      default = [ ];
      description = "Authorized OpenSSH public keys.";
    };

    sops.initial_hashed_password.sopsFile = lib.options.mkOption {
      type = lib.types.pathInStore;
      default = config.rtucek.home.sops.defaultSopsFile;
      description = ''
        Encrypted SOPS file with `initial_hashed_password` key, containing the hashed password.

        Defaults to `config.rtucek.home.sops.defaultSopsFile`.
      '';
    };
  };

  config = {
    # Decrypt hashed password
    sops.secrets.initial_hashed_password = {
      sopsFile = cfg.sops.initial_hashed_password.sopsFile;
      neededForUsers = true;
    };

    # User config
    users.users.rtucek = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.initial_hashed_password.path;
      openssh.authorizedKeys.keys = cfg.defaultAuthorizedSshKeys;
      shell = cfg.defaultShell;
      extraGroups = cfg.defaultGroups;
    };

    # Make sure default shell is installed
    programs.bash.enable = lib.mkDefault (cfg.defaultShell == pkgs.bash);
    programs.fish.enable = lib.mkDefault (cfg.defaultShell == pkgs.fish);
  };
}
