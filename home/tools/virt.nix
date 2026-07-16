{ pkgs, ... }:
{
  home.packages = [
    # docker
    pkgs.docker
    pkgs.docker-compose

    # container
    pkgs.podman
    pkgs.podman-compose

    # container dev
    pkgs.kind
  ];
}
