{ lib, ... }:
{
  # Set a sensitive default, which shall be overridden via
  # `services.automatic-timezoned.enable`, based on the current geolocation.
  #
  # see https://search.nixos.org/options?channel=unstable&query=services.automatic-timezoned.enable
  # for details.
  time.timeZone = lib.mkDefault "Europe/Vienna";

  services = {
    automatic-timezoned.enable = true;
    tzupdate.enable = true;
  };
}
