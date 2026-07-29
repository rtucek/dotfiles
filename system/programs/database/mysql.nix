{ pkgs, ... }:
{
  environment.systemPackages = [
    # We use the MariaDB fork instead of MySQL.
    pkgs.mariadb
    pkgs.mycli
  ];
}
