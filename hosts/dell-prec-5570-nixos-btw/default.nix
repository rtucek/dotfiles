{ inputs, lib, ... }:
let
  rtucekSopsFile = ../../../secrets/users/rtucek-watt.yaml;
in
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/rtucek.nix
    inputs.nixos-hardware.nixosModules.dell-precision-5570
  ];

  networking.hostName = "dell-prec-5570-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/dell-prec-5570-nixos-btw.yaml;

  home-manager.users.rtucek = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "1900x1200@59.9500";
          position = "0x0";
          scale = 1;
        }
      ];
    };
  };

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 250 GB of available disk space
    lv_root.size = "250G";
    # 250 GB of available disk space
    lv_home.size = "250G";
  };

  # Override common home config
  sops.secrets.initial_hashed_password.sopsFile = rtucekSopsFile;
  home-manager.users.rtucek = {
    sops.defaultSopsFile = rtucekSopsFile;

    programs.git.settings = {
      user = {
        name = "Rudolf Tucek";
        email = lib.mkForce "rudolf.tucek@watt-analytics.com";
      };

      signing = {
        key = "0xB4A383288C158721";
      };
    };
  };
}
