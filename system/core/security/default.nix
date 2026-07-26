{ ... }:
{
  imports = [
    ./audit.nix
    ./firewall.nix
    ./pam.nix
    ./sops.nix
    ./ssh.nix
    ./sudo.nix
    ./sysctl.nix
  ];
}
