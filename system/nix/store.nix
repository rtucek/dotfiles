{
  system.stateVersion = "26.05";

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      persistent = true;
    };

    # Run store optimisation on a low-priority timer instead of synchronously
    # after every build/switch (which is what `settings.auto-optimise-store`
    # would do).
    optimise = {
      automatic = true;
      persistent = true;
    };

    settings = {
      # Use hardlinks in order to safe disk space
      auto-optimise-store = true;

      # Enforce security
      sandbox = true;
      require-sigs = true;
      trusted-users = [
        "root"
        "@wheel"
      ];

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      builders-use-substitutes = true;
      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
