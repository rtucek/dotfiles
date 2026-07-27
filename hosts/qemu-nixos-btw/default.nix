{ inputs, home-manager, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users = {
    rtucek = {
      imports = [
        ../../home
      ];

      home = {
        stateVersion = "26.05";
        username = "rtucek";
        homeDirectory = "/home/rtucek";
      };

      programs = {
        sops = {
          defaultSopsFile = ../../secrets/users/rtucek.yaml;
        };

        git = {
          settings = [
            {
              user = {
                name = "Rudolf Tucek";
                email = "tucek.rudolf@gmail.com";
              };
            }
          ];

          signing = {
            format = "openpgp";
            key = "0x49593BD010DE4723";
            signByDefault = true;
          };
        };
      };
    };
  };

  networking.hostName = "qemu-nixos-btw";
  sops.defaultSopsFile = ../../secrets/hosts/qemu-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 50 % of available disk space
    lv_root.size = "50%VG";
    # 25 % of available disk space
    lv_home.size = "25%VG";
  };
}
