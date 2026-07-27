{
  config,
  pkgs,
  home-manager,
  ...
}:
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
    sopsFile = ../../../secrets/users/rtucek.yaml;
    neededForUsers = true;
  };
  security.audit.rules = [
    # User sops dir
    "-a always,exit -F arch=b64 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user"
    "-a always,exit -F arch=b32 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user"
  ];

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
        defaultSopsFile = ../../../secrets/users/rtucek.yaml;
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
