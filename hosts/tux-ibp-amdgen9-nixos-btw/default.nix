{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen9-amd
    ../../modules
  ];

  networking.hostName = "tux-ibp-amdgen9-nixos-btw";
  sops.defaultSopsFile = ../../secrets/private/hosts/tux-ibp-amdgen9-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 250 GB of available disk space
    lv_root.size = "250G";
    # 250 GB of available disk space
    lv_home.size = "250G";
  };

  rtucek = {
    hyprland.monitors = [
      {
        output = "eDP-1";
        mode = "2880x1800@120.0000";
        position = "0x0";
        scale = 1.5;
      }
    ];
  };
}
