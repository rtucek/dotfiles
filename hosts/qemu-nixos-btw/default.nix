{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  networking.hostName = "qemu-nixos-btw";
  sops.defaultSopsFile = ../../secrets/private/hosts/qemu-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 50 % of available disk space
    lv_root.size = "50%VG";
    # 25 % of available disk space
    lv_home.size = "25%VG";
  };
}
