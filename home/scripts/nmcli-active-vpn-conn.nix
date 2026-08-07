{ pkgs, lib, ... }:
let
  nmcli = "${lib.getBin pkgs.networkmanager}/bin/nmcli";
  awk = "${lib.getBin pkgs.gawk}/bin/awk";
  wc = "${lib.getBin pkgs.coreutils-full}/bin/wc";
  jq = "${lib.getBin pkgs.jq}/bin/jq";
in
pkgs.writeShellScriptBin "nmcli-active-vpn-conn.sh" ''
  ALL_ACTIVE_CONNS="$(${nmcli} con show --active)"
  ALL_ACTIVE_VPN_CONNS="$(echo "$ALL_ACTIVE_CONNS" | ${awk} '{ if ($3=="vpn") print $1}')"
  ALL_ACTIVE_VPN_CONNS_CNT="$(echo "$ALL_ACTIVE_VPN_CONNS" | ${wc} -l)"

  if [[ "$ALL_ACTIVE_VPN_CONNS" == "" ]]; then
    echo "{ \"text\": \" 0\", \"tooltip\": \"No active VPN connections\", \"class\": \"inactive\" }"

    exit 0
  fi

  echo "{ \"text\": \" ''${ALL_ACTIVE_VPN_CONNS_CNT}\", \"tooltip\": "$(echo -n "$ALL_ACTIVE_VPN_CONNS" | ${jq} -Rsa .)", \"class\": \"active\" }"

  exit 0
''
