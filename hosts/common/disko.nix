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
                # To be provided via nixos-anywhere.
                # e.g. via...
                #
                # ```
                # nix run github:numtide/nixos-anywhere -- \
                #     --disk-encryption-keys /tmp/disk.key <(echo -n "MyFullDiskPassword123#") \
                #     --flake .#HOSTNAME \
                #     USER@HOST
                # ```
                passwordFile = lib.mkDefault "/tmp/disk.key";
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
      # As a sensitive default, partitions for "/" and "/home" will each
      # get 33 %, leaving the remaining 33 % for extending when needed.
      #
      # Nonetheless, it's generally recommended to that each host defines
      # its own proper volume size.
      volgroup0 = {
        type = "lvm_vg";
        lvs = {
          lv_root = {
            size = lib.mkDefault "33%VG";
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
            size = lib.mkDefault "33%VG";
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
