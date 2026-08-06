{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/rtucek.nix
  ];

  networking.hostName = "tux-ibp-amdgen9-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/tux-ibp-amdgen9-nixos-btw.yaml;

  home-manager.users.rtucek = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "2880x1800@120.0000";
          position = "0x0";
          scale = 1.5;
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
}
