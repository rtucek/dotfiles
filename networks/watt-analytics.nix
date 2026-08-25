{ config, ... }:
{
  sops = {
    secrets.watt_networks = {
      sopsFile = ../secrets/work/watt-analytics/networks.yaml;
      reloadUnits = [ "NetworkManager.service" ];
    };
  };

  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.sops.secrets.watt_networks.path
    ];

    ### WIFI ###
    profiles = {
      wa-local = {
        connection = {
          id = "WA-Local";
          type = "wifi";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "$WA_LOCAL_SSID";
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "$WA_LOCAL_PSK";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "default";
          method = "auto";
        };
      };

      watt = {
        connection = {
          id = "watt";
          type = "wifi";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "$WATT_SSID";
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "$WATT_PSK";
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
