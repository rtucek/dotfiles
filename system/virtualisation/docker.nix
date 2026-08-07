{ ... }:
{
  virtualisation.docker = {
    enable = true;

    # Needed for having `--restart=always` flag working.
    # Otherwise, systemd will only start docker on demand upon socket
    # activation.
    enableOnBoot = true;

    autoPrune = {
      enable = true;
      persistent = true;
      dates = "weekly";
    };
  };
}
