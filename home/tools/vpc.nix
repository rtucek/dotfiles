{ lib, pkgs, ... }:
let
  # Minimum version we want is v1.160.0, as it covers
  # https://github.com/digitalocean/doctl/pull/1844
  minVersion = "1.160.0";
  minVersionHash = "sha256-LXALzs5oubT1uL+sgA0LsaoFbir3e8JYVlIiJv6U5J4=";
  doctl' =
    if lib.versionAtLeast pkgs.doctl.version minVersion then
      # Throw exception, once this overlay becomes superfluous.
      throw "Overlay not required anymore - use upstream version from channel!"
    else
      pkgs.doctl.overrideAttrs (old: {
        version = minVersion;
        src = pkgs.fetchFromGitHub {
          owner = "digitalocean";
          repo = "doctl";
          rev = "v${minVersion}";
          hash = minVersionHash;
        };
        vendorHash = null;
        ldflags =
          let
            t = "github.com/digitalocean/doctl";
          in
          [
            "-X ${t}.Major=${lib.versions.major minVersion}"
            "-X ${t}.Minor=${lib.versions.minor minVersion}"
            "-X ${t}.Patch=${lib.versions.patch minVersion}"
            "-X ${t}.Label=release"
          ];
      });
in
{
  home.packages = [
    # digital ocean cli
    doctl'
  ];
}
