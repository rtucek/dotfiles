{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/rtucek.nix
  ];

  networking.hostName = "dell-xps9360-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/dell-xps9360-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 100 GB of available disk space
    lv_root.size = "100G";
    # 100 GB of available disk space
    lv_home.size = "100G";
  };
}
