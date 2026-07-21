{ lib, ... }:
{
  disko.devices = {
    disk = {
      main = {
        device = lib.mkDefault "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "volgroup0";
                # To be provided via nisos-anywhere.
                # e.g. via...
                #
                # ```
                # nix run github:numtide/nixos-anywhere -- \
                #     --disk-encryption-keys /tmp/disk.key <(echo -n "MyFullDiskPassword123#") \
                #     --flake .#qemu-nixos-btw \
                #     user@host
                # ```
                passwordFile = "/tmp/disk.key";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "volgroup0";
                };
                # additionalKeyFiles = [ ];
                # extraOpenArgs = [ ];
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      volgroup0 = {
        type = "lvm_vg";
        lvs = {
          lv_root = {
            size = "33%VG";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };

          lv_home = {
            size = "33%VG";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };
}
