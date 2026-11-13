{ lib, ... }:
{
  options.rtucek.virtualisation = {
    docker.enable = lib.options.mkEnableOption "Enable Docker container runtime";
    podman.enable = lib.options.mkEnableOption "Enable Podman container runtime";
    containers.enable = lib.options.mkEnableOption "Enable shared OCI container tooling and nixos-container CLI";
  };
}
