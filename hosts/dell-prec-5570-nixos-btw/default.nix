{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common/users/rtucek.nix
    inputs.nixos-hardware.nixosModules.dell-precision-5570
  ];

  networking.hostName = "dell-prec-5570-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/dell-prec-5570-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 250 GB of available disk space
    lv_root.size = "250G";
    # 250 GB of available disk space
    lv_home.size = "250G";
  };
}
