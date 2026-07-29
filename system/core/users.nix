{ lib, pkgs, ... }:
{
  services.userborn = {
    enable = true;
  };

  # By default, we'd want to harden towards immutable users.
  # If needed, this may be overridden.
  users = {
    mutableUsers = lib.mkDefault false;
  };
}
