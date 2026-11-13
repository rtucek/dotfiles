{ config, lib, ... }:
{
  virtualisation.podman = lib.mkIf config.rtucek.virtualisation.podman.enable {
    enable = true;

    # Avoid conflicts with docker
    dockerCompat = false;
    dockerSocket.enable = false;

    autoPrune = {
      enable = true;
      dates = "weekly";
    };

    defaultNetwork = {
      settings = {
        # Allow container-to-container DNS resolution
        dns_enabled = true;
      };
    };
  };
}
