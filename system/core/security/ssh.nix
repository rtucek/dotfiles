{ lib, pkgs, ... }:
{
  # OpenSSH should generally be disabled by default and only activated when
  # needed via systemd.
  systemd.services.sshd.wantedBy = lib.mkForce [ ];

  services.openssh = {
    enable = true;

    allowSFTP = true;

    # Rely on the NixOS packaging team to have algorithms up2date.
    enableRecommendedAlgorithms = true;

    # ... never ever ...
    settings.PermitRootLogin = lib.mkForce "no";
  };

  environment.systemPackages = [
    # In any case, install openssh anyways, since we'll need the ssh client.
    pkgs.openssh
  ];
}
