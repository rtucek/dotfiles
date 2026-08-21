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
      default = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8X/6YtTiciDgv4SBbr+sHRfqbyD/xTulOgJuifcTlDDPwA8mJc19EI/HyDgGHQm/+GHK6YLxCQvxa5QzhgDxr9FILH4724NM2HSRADpA2NF5SqRNqK0uwnXof4U3H0zRr1mFUzoUJUvV7T2ammAC9SdPa+gFgwM7erpTd4MYpsawmzfHDGtNxdYBVZZXQQ0G587zUEG5VZcogvGehANNTC2s4se4wher56Jh5j/nwVhO11LZ7NMXJaxl9fWyBEWj58ybX8eLOHfWT43dyZFXgTNXMTzvmUSnCZGVR7Kqk8porKZBT8hvksbEYAq45aNDYl2J1ArSLVjJEHT4zUv7G8iUHtDkKStcS9ZaxhIIOluHuQAIa+R9am/LPD62WjnEJ5F72JK3BRoaVP/JGe5IClWSQqkqG4pgn3MHuYW7zwk4QZcagLM0Ecv8aXcgIO3kJ8vwjJzH+vsdfBGaXOdPKBbKNLaEG6w0phvyt7N3P3N6yyN28gk812ALKScsiSmYEAmnJFzj3ot/yUs+9EduXsNCHLJch+a1xcHuaPMEJHUzbOLbi/DFikq85wsa+U2h89D085voepp1uzRLS5BHzvCFk8t7d5boOZxX39Pat5wHs2QbdC2z2bB0NpQphTWnnc2TiWjJBpx9MVbZGB3Svzy50VZA2hJBhuaM6yG7yYw== cardno:13_364_058"
      ];
      description = "Authorized OpenSSH public keys.";
    };

    sops.initial_hashed_password.sopsFile = lib.options.mkOption {
      type = lib.types.pathInStore;
      default = config.rtucek.home.sops.defaultSopsFile;
      description = ''
        Encrypted SOPS file with with `initial_hashed_password` key, containing the hashed password.

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
