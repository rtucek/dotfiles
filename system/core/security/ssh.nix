{ lib, pkgs, ... }:
{
  services.openssh = {
    # OpenSSH should generally be disabled by default. Nonetheless, for the
    # event the sshd will be manually (and hopefully only temporarily) started
    # and/or activated via an overlay, this config shall apply with the
    # following  sensitive defaults.
    enable = false;

    allowSFTP = true;

    # Rely on the NixOS packaging team to have algorithms up2date.
    enableRecommendedAlgorithms = true;

    # ... never ever ...
    settings.PermitRootLogin = lib.mkForce "no";
  };

  environment.systemPackages = [
    # In any case, install openssh anyways, since we'll need the ssh client
    # anyways.
    pkgs.openssh
  ];
}
