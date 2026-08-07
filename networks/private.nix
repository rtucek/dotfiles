{ config, ... }:
{
  sops = {
    secrets.private_networks = {
      sopsFile = ../secrets/network/private.yaml;
      reloadUnits = [ "NetworkManager.service" ];
    };
  };

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.sops.secrets.private_networks.path
    ];

    profiles = {
      home = {
        connection = {
          id = "Home";
          type = "wifi";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "$HOME_SSID";
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "$HOME_PSK";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "default";
          method = "auto";
        };
      };

      mobile_hotspot = {
        connection = {
          id = "Pixel6 Mobile Hotspot";
          type = "wifi";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "$MOBILE_HOTSPOT_SSID";
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "$MOBILE_HOTSPOT_PSK";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "default";
          method = "auto";
        };
      };
    };
  };
}
