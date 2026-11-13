{
  inputs,
  config,
  lib,
  ...
}:
let
  # The nixpkgs-stable Nvidia driver (595.71.05) fails to build its kernel module against
  # Linux v7.2+, since that kernel release removed `strncpy()` entirely (NVIDIA/open-gpu-kernel-modules#1227).
  # NVIDIA fixed this upstream in driver 595.91.07, which hasn't been promoted to nixpkgs' stable
  # channel yet (https://github.com/NixOS/nixpkgs/issues/554125) - pull it in directly until it is.
  minVersion = "595.91.07";
  minVersionNvidia = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = minVersion;
    sha256_64bit = "sha256-yiPIjdJLB6GRZE4eEc+3vN11NzBXSa9A+YABiwleYxM=";
    sha256_aarch64 = "sha256-fqkN7ONFXtTeXyu2mQxorrk362Epxq3bz88hhKYQzwQ=";
    openSha256 = "sha256-OB8Epd+qn/WywxsPiFpxEOAzlJqb6I1SyRoV3a8l71k=";
    settingsSha256 = "sha256-QzT8Cw1luuZGP9DUje3HN/0ngiayqHURj+bqPsxlJ5w=";
    persistencedSha256 = "sha256-3JQBaNmkwxvCXv9q8aHKas6VZM/JjLsuilC2t7ET0u0=";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    inputs.nixos-hardware.nixosModules.dell-precision-5570
    ../../networks/watt-analytics.nix
    ./sops.nix
    ./scripts.nix
    ./tmuxinator.nix
  ];

  hardware.nvidia.package =
    if lib.versionAtLeast config.boot.kernelPackages.nvidiaPackages.stable.version minVersion then
      # Remove this workaround now that upstream covers it - use nvidiaPackages.stable directly!
      throw "nvidia driver workaround no longer required - use upstream nvidiaPackages.stable!"
    else
      minVersionNvidia;

  networking.hostName = "dell-prec-5570-nixos-btw";
  sops.defaultSopsFile = ../../secrets/work/watt-analytics/dell-prec-5570-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 250 GB of available disk space
    lv_root.size = "250G";
    # 250 GB of available disk space
    lv_home.size = "250G";
  };

  rtucek = {
    home = {
      sops.defaultSopsFile = ../../secrets/work/watt-analytics/rtucek.yaml;
    };

    git = {
      user.email = "rudolf.tucek@watt-analytics.com";
      gpg.signingKey = "0x1044945481B99D3E";
      ignores = [
        "/.wactl/"
      ];
    };

    # Add fingerprint support
    auth.fprintd.enable = true;

    hyprland.monitors = [
      {
        output = "eDP-1";
        mode = "1900x1200@59.9500";
        position = "0x0";
        scale = 1;
      }
      {
        # Home | Main monitor
        output = "desc:LG Electronics LG ULTRAGEAR 408BOHE0K857";
        mode = "2560x1440@59.95";
        position = "1920x0";
        scale = 1;
      }
      # Office Watt Analytics | Main monitor
      {
        output = "desc:LG Electronics LG HDR 4K 0x00087BA3";
        mode = "3840x2160@60.00";
        position = "1920x0";
        scale = 1.5;
      }
      # Office Watt Analytics | Right monitor
      {
        output = "desc:Lenovo Group Limited LEN L27q-30 U162BVYX";
        mode = "2560x1440@59.95";
        position = "4480x0";
        scale = 1;
      }
    ];

    ai.claude-code.enable = true;

    virtualisation = {
      docker.enable = true;
      podman.enable = true;
      containers.enable = true;
    };
  };
}
