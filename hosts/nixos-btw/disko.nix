{
  disko.devices = {
    disk = {
      main = {
        # When using disko-install, we will overwrite this value from the commandline
        device = "/dev/disk/by-id/some-disk-id";
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
                extraOpenArgs = [ ];
                settings = {
                };
                additionalKeyFiles = [ ];
                content = {
                  type = "lvm_pv";
                  vg = "volgroup0";
                };
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
            size = "30%VG";
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
            size = "30%VG";
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
