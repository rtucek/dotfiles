final: prev:
let
  # Minimum version we want is v2.0.4, which is only available on
  # nixos-unstable as of writing:
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ni/nix-fast-build/package.nix
  minVersion = "2.0.4";
  minVersionHash = "sha256-sc/NZIHkRhgyAzK8Xn6G++vGrl/Uf7QHh+J5fnZ/o4s=";
in
{
  nix-fast-build =
    if prev.lib.versionAtLeast prev.nix-fast-build.version minVersion then
      # Throw exception, once this overlay becomes superfluous.
      throw "Overlay for `nix-fast-build` is not required anymore - use upstream version from channel!"
    else
      prev.nix-fast-build.overrideAttrs (old: {
        version = minVersion;
        src = prev.fetchFromGitHub {
          owner = "Mic92";
          repo = "nix-fast-build";
          rev = minVersion;
          hash = minVersionHash;
        };
      });
}
