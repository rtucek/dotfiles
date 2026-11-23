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

    {
      # Github's own GPG key, used for signing commits on behalf of their users.
      # For instance, commits created by merging PRs via the web UI.
      # rsa4096/0xB5690EEEBB952194 (used as of 2024-01-16; currently in-use)
      # rsa2048/0x4AEE18F83AFDEB23 (used as of 2017-08-16; now expired)
      source = pkgs.fetchurl {
        url = "https://github.com/web-flow.gpg";
        hash = "sha256-bor2h/YM8/QDFRyPsbJuleb55CTKYMyPN4e9RGaj74Q=";
      };
      trust = "ultimate";
    }

    ## Legacy keys
    # Old keys, which have expired, are revoked and/or are no longer in use.

    {
      # 3nd generation of r.tucek@ixolit.com + r.tucek@ixopay.com, generated in 2022-10.
      # Added IXOPAY email address + got a new Yubikey due to port-issues on new work laptop (old
      # Yubikey was USB; new Yubikey was USB-C).
      source = pkgs.fetchurl {
        url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9fb53baa52695fc2a6f2aea58541357f8812998a";
        hash = "sha256-4Ki1+mwQVcc7olUoXATIMcd++9LBluX1+fSvKH1+Qbg=";
      };
      trust = "ultimate";
    }

    {
      # 2nd generation of r.tucek@ixolit.com, generated in 2020-06.
      # Based on the initial Yubikey rollout at IXO.
      # Used for signing and authentication.
      source = pkgs.fetchurl {
        url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x42c6fe7db7f159138ac398764f9f86ced271636e";
        hash = "sha256-UlSa5r24dIqESeMDFtWm70xaoi5/KYM1XpplW8V9yts=";
      };
      trust = "ultimate";
    }

    {
      # 1st generation of r.tucek@ixolit.com key, generated in 2017-06.
      # Used at the early days, when we didn't had Yubikeys.
      # Only used for signing purpose.
      source = pkgs.fetchurl {
        url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x5d5a149617fed62e50e37eb86442f831eb470ff5";
        hash = "sha256-81VazxQczWM8l1gEBuYBiZIu8uGtWO75/TIAz3Q1hLs=";
      };
      trust = "ultimate";
    }

    {
      # Key, generated for tucek.rudolf@gmail.com in 2016-10.
      # Used for ~10 years until 2026-07 for signing commits and authentication.
      source = pkgs.fetchurl {
        url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xd4b423c3733ebcaa1c7171e641e89aaac718851c";
        hash = "sha256-edHV9qpFcjp40XC1d8xqoMnZtWnENIgBQIpFdOcnyz0=";
      };
      trust = "ultimate";
    }

    # {
    #   # Test key of tucek.rudolf@gmail.com, generated for crypto-experiments in 2016-06.
    #   # Key got officially revoked.
    #   source = pkgs.fetchurl {
    #     url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xb9d2fddcaa3410745df8fc956f29650ff90cbee6";
    #     hash = "sha256-76tEiMKYodF57RpVEAyL5MIOEBG1eHbN/5q8mWoP1sg=";
    #   };
    #   trust = "ultimate";
    # }

    {
      # Test key of tucek.rudolf@gmail.com, generated for crypto-experiments in 2014-04.
      # Unfortunately, this key was never properly revoked.
      source = pkgs.fetchurl {
        url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3c028d883dd9f06bcedb0876503aad0876c056b5";
        hash = "sha256-kYpTi6yM6MCeggOU+j0t6Ookip1Yi9r2vQ+e+n/qTX4=";
      };
      trust = "ultimate";
    }

    {
      # 1st key, generated for tucek.rudolf@gmail.com in 2013-06.
      # This key wasn't backed-up when migrating to a new Laptop.
      source = pkgs.fetchurl {
        url = "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x83e7b166b97f2fb952715d7e2e0c9793bb1a16e9";
        hash = "sha256-R6wmSPMGGXmY9UbzHbJd28MedZZUXI73+Z3au7slL+A=";
      };
      trust = "ultimate";
    }
  ];
}
