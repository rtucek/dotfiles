# brave and brave-origin were dropped from nixpkgs for lacking a committer
# among their maintainers: https://github.com/NixOS/nixpkgs/pull/582838
#
# They were re-added (with bachp as maintainer) shortly after:
# https://github.com/NixOS/nixpkgs/pull/584534
# https://github.com/NixOS/nixpkgs/pull/584546 (backport to release-26.05)
#
# As of writing, that backport hasn't reached the nixos-26.05 *channel*
# branch this flake tracks (channel bumps lag release-26.05 by Hydra eval
# time), so the packages are still missing here. This overlay vendors the
# package definitions from the backport commit (release-26.05@cc588038) to
# tide things over.
#
# ./brave/* is a verbatim copy of pkgs/applications/networking/browsers/brave
# at that commit - do not hand-edit it. Re-fetch from a newer commit instead
# if upstream changes it before the channel catches up.
final: prev:
let
  vendored = import ./brave { inherit (prev) callPackage; };

  # nixpkgs replaces a removed package's attribute with a `throw` stub
  # rather than deleting it outright, so a plain `prev ? name` is always
  # true. Actually evaluating the attribute is the only way to tell a real
  # package apart from a stub.
  upstreamAvailable = name: (prev ? ${name}) && (builtins.tryEval prev.${name}).success;
in
{
  brave =
    if upstreamAvailable "brave" then
      # Throw exception, once this overlay becomes superfluous.
      throw "Overlay not required anymore - use upstream version from channel!"
    else
      vendored.brave;
  brave-origin =
    if upstreamAvailable "brave-origin" then
      throw "Overlay not required anymore - use upstream version from channel!"
    else
      vendored.brave-origin;
}
