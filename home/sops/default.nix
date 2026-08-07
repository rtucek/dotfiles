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
    age = {
      keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      generateKey = false;
    };
  };
}
