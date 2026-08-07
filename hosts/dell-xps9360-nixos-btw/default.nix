{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/rtucek.nix
  ];

  networking.hostName = "dell-xps9360-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/dell-xps9360-nixos-btw.yaml;

  home-manager.users.rtucek = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "3200x1800@59.98200";
          position = "0x0";
          scale = 1.6;
        }
      ];
    };
  };

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 100 GB of available disk space
    lv_root.size = "100G";
    # 100 GB of available disk space
    lv_home.size = "100G";
  };
}
