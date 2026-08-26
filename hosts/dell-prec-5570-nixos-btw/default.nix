{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    inputs.nixos-hardware.nixosModules.dell-precision-5570
    ../../networks/watt-analytics.nix
  ];

  # Force using Linux 7.1 for now, since with the most recent flake update, we'd run the Linux v7.2
  # kernel, which is currently incompatible via the Nvidia kernel module on 595.71.05.
  # In particular, this affects both, the open an proprietary driver.
  # The solution for now is to stay on Linux v7.1 until the Nvidia kernel modules have been adjusted
  # for the latest kernel.
  #
  # see also https://www.reddit.com/r/NixOS/comments/1vut6in/i_have_a_problem_with_the_nvidia_driver_while_i/
  boot.kernelPackages =
    let
      currentIncompatibleVersion_7_2 = "595.71.05";
      checkUpstreamVersion_7_2 = pkgs.linuxKernel.packages.linux_7_2.nvidia_x11_latest.version;
    in
    if lib.versionOlder currentIncompatibleVersion_7_2 checkUpstreamVersion_7_2 then
      throw "Newer Nvidia kernel module released (before v${currentIncompatibleVersion_7_2}; now v${checkUpstreamVersion_7_2} upstream) - try Linux 7.2 (or later) again!"
    else
      # Fall back to Linux v7.1 for now
      lib.mkForce pkgs.linuxKernel.packages.linux_7_1;

  networking.hostName = "dell-prec-5570-nixos-btw";
  sops.defaultSopsFile = ../../secrets/work/watt-analytics/dell-prec-5570-nixos-btw.yaml;

  disko.devices.lvm_vg.volgroup0.lvs = {
    # 250 GB of available disk space
    lv_root.size = "250G";
    # 250 GB of available disk space
    lv_home.size = "250G";
  };

  home-manager.users.rtucek = {
    sops = {
      secrets = {
        "ssh/private_key" = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.ssh/id_ed25519";
        };
        "ssh/public_key" = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.ssh/id_ed25519.pub";
        };
        gh_token = { };
        do_token = { };
      };
      templates = {
        nixConf = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.config/nix/nix.conf";
          content = ''
            access-tokens = github.com=${config.home-manager.users.rtucek.sops.placeholder.gh_token}
          '';
        };
        ghHostsConf = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.config/gh/hosts.yml";
          file = (pkgs.formats.yaml { }).generate "" {
            "github.com" = {
              users = {
                rtucek = {
                  oauth_token = config.home-manager.users.rtucek.sops.placeholder.gh_token;
                };
              };
              git_protocol = "ssh";
              oauth_token = config.home-manager.users.rtucek.sops.placeholder.gh_token;
              user = "rtucek";
            };
          };
        };
        doConf = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.config/doctl/config.yaml";
          file = (pkgs.formats.yaml { }).generate "" {
            access-token = config.home-manager.users.rtucek.sops.placeholder.do_token;
          };
        };
      };
    };
  };

  rtucek = {
    home = {
      sops.defaultSopsFile = ../../secrets/work/watt-analytics/rtucek.yaml;
    };

    git = {
      user.email = "rudolf.tucek@watt-analytics.com";
      gpg.signingKey = "0x1044945481B99D3E";
    };

    # Add fingerprint support
    auth.fprintd.enable = true;

    hyprland.monitors = [
      {
        output = "eDP-1";
        mode = "1900x1200@59.9500";
        position = "0x0";
        scale = 1;
      }
      {
        # Home | Main monitor
        output = "desc:LG Electronics LG ULTRAGEAR 408BOHE0K857";
        mode = "2560x1440@59.95";
        position = "1920x0";
        scale = 1;
      }
      # Office Watt Analytics | Main monitor
      {
        output = "desc:LG Electronics LG HDR 4K 0x00087BA3";
        mode = "3840x2160@60.00";
        position = "1920x0";
        scale = 1.5;
      }
      # Office Watt Analytics | Right monitor
      {
        output = "desc:Lenovo Group Limited LEN L27q-30 U162BVYX";
        mode = "2560x1440@59.95";
        position = "4480x0";
        scale = 1;
      }
    ];
  };
}
