{
  # There's lots of network-related security config already done via ./sysctl.nix

  networking.firewall.enable = true;

  # Have iptables replaced with more modern nftables implementation.
  networking.nftables.enable = true;
}
