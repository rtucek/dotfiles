{ lib, ... }:
{
  time.timeZone = lib.mkDefault "Europe/Vienna";

  services = {
    automatic-timezoned.enable = true;
  };
}
