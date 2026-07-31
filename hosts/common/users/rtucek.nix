{
  config,
  pkgs,
  ...
}:
let
  rtucekSopsFile = ../../../secrets/users/rtucek.yaml;
in
{
  # User config
  users.users.rtucek = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.initial_hashed_password.path;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8X/6YtTiciDgv4SBbr+sHRfqbyD/xTulOgJuifcTlDDPwA8mJc19EI/HyDgGHQm/+GHK6YLxCQvxa5QzhgDxr9FILH4724NM2HSRADpA2NF5SqRNqK0uwnXof4U3H0zRr1mFUzoUJUvV7T2ammAC9SdPa+gFgwM7erpTd4MYpsawmzfHDGtNxdYBVZZXQQ0G587zUEG5VZcogvGehANNTC2s4se4wher56Jh5j/nwVhO11LZ7NMXJaxl9fWyBEWj58ybX8eLOHfWT43dyZFXgTNXMTzvmUSnCZGVR7Kqk8porKZBT8hvksbEYAq45aNDYl2J1ArSLVjJEHT4zUv7G8iUHtDkKStcS9ZaxhIIOluHuQAIa+R9am/LPD62WjnEJ5F72JK3BRoaVP/JGe5IClWSQqkqG4pgn3MHuYW7zwk4QZcagLM0Ecv8aXcgIO3kJ8vwjJzH+vsdfBGaXOdPKBbKNLaEG6w0phvyt7N3P3N6yyN28gk812ALKScsiSmYEAmnJFzj3ot/yUs+9EduXsNCHLJch+a1xcHuaPMEJHUzbOLbi/DFikq85wsa+U2h89D085voepp1uzRLS5BHzvCFk8t7d5boOZxX39Pat5wHs2QbdC2z2bB0NpQphTWnnc2TiWjJBpx9MVbZGB3Svzy50VZA2hJBhuaM6yG7yYw== cardno:13_364_058"
    ];
    shell = pkgs.fish;
    extraGroups = [
      "wheel" # sudo make me a sandwich
      "docker" # run docker commands without sudo
    ];
  };

  # Decrypt hashed password
  sops.secrets.initial_hashed_password = {
    sopsFile = rtucekSopsFile;
    neededForUsers = true;
  };

  # Audit access to age key
  #
  # Note: we can't use `security.audit.rules`, as these rules will be merged
  # into systemd's `audit-rules-nixos.service` unit, which runs immediately
  # after sysinit.target.
  #
  # However, this is too early, as at this time, LVM hasn't yet mounted the
  # /home directory and therefore, fails to load the unit.
  #
  # The workaround is to load rules, referencing paths in /home in a separate in
  # a separate systemd unit, depending on the `home.mount` target.
  systemd.services.audit-rules-nixos-home-age =
    let
      auditrules = pkgs.writeTextFile {
        name = "audit-home.rules";
        text = ''
          -D -k secrets_dir_user
          -a always,exit -F arch=b64 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user
          -a always,exit -F arch=b32 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user
        '';
      };
    in
    {
      description = "Load Audit Rules after LVM mount";
      wantedBy = [ "home.mount" ];
      after = [ "home.mount" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.audit}/bin/auditctl -R ${auditrules}";
      };
    };

  # Make sure default shell is installed
  programs.fish.enable = true;

  # home manager config
  home-manager.users = {
    rtucek = {
      imports = [
        ../../../home
      ];

      home = {
        stateVersion = "26.05";
        username = "rtucek";
        homeDirectory = "/home/rtucek";
      };

      sops = {
        defaultSopsFile = rtucekSopsFile;
      };

      programs = {
        git = {
          settings = [
            {
              user = {
                name = "Rudolf Tucek";
                email = "tucek.rudolf@gmail.com";
              };
            }
          ];

          signing = {
            format = "openpgp";
            key = "0x49593BD010DE4723";
            signByDefault = true;
          };
        };
      };
    };
  };
}
