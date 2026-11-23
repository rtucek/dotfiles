{ pkgs, ... }:
{
  programs.gpg.publicKeys = [
    ## Actively used keys

    {
      # Private Yubikey (serial 13364058)
      # tucek.rudolf@gmail.com
      source = pkgs.fetchurl {
        url = "https://keys.openpgp.org/vks/v1/by-fingerprint/72067CD79C9ED21F2A626439416CF1EF9AAF90BC";
        hash = "sha256-o5mdgfLEhhCT3IIW+pJX2heFNXkAeYre3mu1x6dbugE=";
      };
      trust = "ultimate";
    }

    {
      # Watt Analytics
      # rudolf.tucek@watt-analytics.com
      source = pkgs.fetchurl {
        url = "https://keys.openpgp.org/vks/v1/by-fingerprint/B8CD0CF2730CA8D861671DC4B4A383288C158721";
        hash = "sha256-5AVpttZMWxuAeuE0MnPrjzVkBON6jK91EFTTc7cimLU=";
      };
      trust = "ultimate";
    }
  ];
}
