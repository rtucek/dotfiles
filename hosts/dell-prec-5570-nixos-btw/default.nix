{
  inputs,
  pkgs,
  lib,
  ...
}:
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

  # Fallback to Linux LTS v6.18 for now, since the Nvidia drivers - both, open and proprietary - are
  # broken as of Linux v7.2 due to changes in the kernel's source code.
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

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
  };

  # AI stuff
  environment.systemPackages = [
    pkgs.claude-code
    pkgs.rtk
  ];
  nixpkgs = {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "claude-code"
      ];
  };
}
