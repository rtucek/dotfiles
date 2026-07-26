{ ... }:
{
  imports = [
    ./audit.nix
    ./firewall.nix
    ./sops.nix
    ./ssh.nix
    ./sudo.nix
    ./sysctl.nix
  ];
}
