let
  brokenVersion = "2026-07-07";
in
final: prev: {
  # The nix build of tela-circle-icon-theme is currently broken as per
  # [2026-07-07](https://github.com/vinceliuice/Tela-circle-icon-theme/releases/tag/2026-07-07).
  # This is due to the fact, that the upstream is apparently shipping broken symlinks.
  #
  # The regression was initially introduced via NixOS/nixpkgs#571126 and back-porter to the 26.05
  # channel via NixOS/nixpkgs#570253.
  #
  # A build fix for the unstable channel already exists via NixOS/nixpkgs#571126, however, the
  # relevant back-port for the 26.05 channel in NixOS/nixpkgs#571518 hasn't been merged yet, hence
  # we try to compensate with this override.
  tela-circle-icon-theme =
    if
      # We may not need this overlay workaround anymore if either...
      # ... a) the upstream version has changed...
      (prev.tela-circle-icon-theme.version != brokenVersion)
      # ... or b) we don't observe the NixOS' package mantainer's workaround from
      # NixOS/nixpkgs#571126 anymore in the install phase.
      || (prev.lib.hasInfix "-xtype l" prev.tela-circle-icon-theme.installPhase)
    then
      # Throw exception, once this overlay becomes superfluous.
      throw
        "Overlay not required anymore - the upstream version may no longer ship broken symlinks!"
    else
      prev.tela-circle-icon-theme.overrideAttrs (old: {
        # remove broken symlinks and delete them
        postInstall = "find $out -xtype l -print -delete";
      });
}
