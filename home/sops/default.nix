{ config, inputs, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    log = [
      "keyImport"
      "secretChanges"
    ];
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../secrets/users/rtucek.yaml;
    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      generateKey = false;
    };
  };
}
