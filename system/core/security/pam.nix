{ ... }:
{
  security.pam = {
    services = {
      # Required for home manager's hyprlock a implementation.
      hyprlock = {
        enable = true;
      };
    };
  };
}
