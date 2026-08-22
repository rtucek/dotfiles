{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9360
    ../../modules
  ];

  networking.hostName = "dell-xps9360-nixos-btw";
  sops.defaultSopsFile = ../../secrets/private/hosts/dell-xps9360-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 100 GB of available disk space
    lv_root.size = "100G";
    # 100 GB of available disk space
    lv_home.size = "100G";
  };

  rtucek = {
    hyprland.monitors = [
      {
        output = "eDP-1";
        mode = "3200x1800@59.98200";
        position = "0x0";
        scale = 1.6;
      }
    ];
  };
}
