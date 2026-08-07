{ ... }:
{
  virtualisation.podman = {
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
