{ pkgs, ... }:
{
  networking = {
    # DNS resolver via systemd
    resolvconf = {
      enable = true;
    };

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };
  };
}
