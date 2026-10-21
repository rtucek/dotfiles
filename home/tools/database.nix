{ pkgs, ... }:
{
  home.packages = [
    pkgs.dbeaver-bin

    # We use the MariaDB fork instead of MySQL.
    pkgs.mariadb
    pkgs.mycli

    # postgres
    pkgs.postgresql
    pkgs.pgcli

    # Clickhouse
    pkgs.clickhouse

    # sqlite
    pkgs.sqlite
    pkgs.litecli
  ];
}
