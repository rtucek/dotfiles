{
  sops = {
    log = [
      "keyImport"
      "secretChanges"
    ];
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/users/rtucek.yaml;
    age = {
      keyFile = "/secrets/keys.txt";
      generateKey = false;
    };
  };
}
