{ pkgs, ... }:
{
  home.packages = [
    # General
    pkgs.inetutils
    pkgs.iproute2
    pkgs.ethtool

    # DNS
    pkgs.doggo
    pkgs.dig
    pkgs.whois

    # Debugging
    pkgs.ipcalc
    pkgs.traceroute
    pkgs.mtr # Better alternative to traceroute
    pkgs.netcat-gnu
    pkgs.nmap
    pkgs.tcpdump
    pkgs.ptcpdump # Better alternative to traceroute

    # Monitoring
    pkgs.speedtest-cli
  ];
}
