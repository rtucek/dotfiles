{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.osquery
  ];

  services.osquery = {
    enable = true;
  };
}
