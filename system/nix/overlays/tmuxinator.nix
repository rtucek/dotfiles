final: prev:
let
  # Minimum version we want is v3.4.1, which is only available on
  # nixos-unstable as of writing:
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/tm/tmuxinator/package.nix
  minVersion = "3.4.1";
  minVersionHash = "sha256-2BZgu3vybhpoScScq42yr80DYI343vqlQVQv2AOG48I=";
in
{
  tmuxinator =
    if prev.lib.versionAtLeast prev.tmuxinator.version minVersion then
      # Throw exception, once this overlay becomes superfluous.
      throw "Overlay not required anymore - use upstream version from channel!"
    else
      prev.tmuxinator.overrideAttrs (old: {
        version = minVersion;
        suffix = minVersion;
        name = prev.lib.replaceStrings [ old.version ] [ minVersion ] old.name;
        src = prev.fetchurl {
          url = "https://rubygems.org/gems/tmuxinator-${minVersion}.gem";
          hash = minVersionHash;
        };
        postInstall = prev.lib.replaceStrings [ old.version ] [ minVersion ] old.postInstall;
      });
}
