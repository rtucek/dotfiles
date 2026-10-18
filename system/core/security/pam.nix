{ ... }:
{
  security.pam = {
    services = {
      # Required for home manager's hyprlock implementation.
      hyprlock = {
        enable = true;
      };
    };
  };
}
