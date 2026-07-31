{ pkgs, ... }:
{
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "opportunistic";
      DNSSEC = "allow-downgrade";
    };
  };

  networking = {
    # /etc/resolv.conf to be managed via systemd-resolved
    # resolvconf = {
    #   enable = true;
    # };

    nameservers = [
      # Cloudflare
      "1.1.1.1"
      "1.0.0.1"
      # Google
      "8.8.8.8"
    ];

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };
  };

  programs.nm-applet = {
    enable = true;
    indicator = false;
  };
}
