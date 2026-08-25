{ config, ... }:
{
  sops = {
    # Network Manager ENV secerts
    secrets.watt_networks = {
      sopsFile = ../secrets/work/watt-analytics/networks.yaml;
      reloadUnits = [ "NetworkManager.service" ];
    };

    # vpn-watt certs
    secrets.vpn_watt_ca = {
      sopsFile = ../secrets/work/watt-analytics/networks.yaml;
      reloadUnits = [ "NetworkManager.service" ];
    };
    secrets.vpn_watt_cert = {
      sopsFile = ../secrets/work/watt-analytics/networks.yaml;
      reloadUnits = [ "NetworkManager.service" ];
    };
    secrets.vpn_watt_key = {
      sopsFile = ../secrets/work/watt-analytics/networks.yaml;
      reloadUnits = [ "NetworkManager.service" ];
    };
    secrets.vpn_watt_tls_crypt = {
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

      ### VPN ###
      vpn-watt = {
        connection = {
          id = "vpn-watt";
          type = "vpn";
          autoconnect = false;
        };
        vpn = {
          auth = "SHA256";
          cert-pass-flags = 0;
          challenge-response-flags = 2;
          cipher = "AES-256-CBC";
          connection-type = "tls";
          dev = "tun";
          remote-cert-tls = "server";
          tls-version-min = "1.2";
          service-type = "org.freedesktop.NetworkManager.openvpn";
          remote = "$VPN_WATT_REMOTE";
          verify-x509-name = "$VPN_WATT_X509_VERIFY";
          ca = config.sops.secrets.vpn_watt_ca.path;
          cert = config.sops.secrets.vpn_watt_cert.path;
          key = config.sops.secrets.vpn_watt_key.path;
          tls-crypt = config.sops.secrets.vpn_watt_tls_crypt.path;
        };
        vpn-secrets = {
          cert-pass = "$VPN_WATT_CERT_PASS";
        };
        ipv4 = {
          method = "auto";
          route-metric = 1000;
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
      };
    };
  };
}
