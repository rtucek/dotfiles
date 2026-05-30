{ ... }:
{
  imports = [
    ./firewall.nix
    ./ssh.nix
    ./sudo.nix
    ./sysctl.nix
  ];
}
