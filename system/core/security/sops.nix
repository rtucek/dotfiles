{
  sops = {
    log = [
      "keyImport"
      "secretChanges"
    ];
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/secrets/keys.txt";
      generateKey = false;
    };
  };
}
