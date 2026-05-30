{
  system.stateVersion = "26.05";

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      gc = {
        automatic = true;
        dates = "weekly";
        persitent = true;
      };

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
