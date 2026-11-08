# tuxedo-drivers 4.20.1 (as pinned on the nixos-26.05 channel branch) fails
# to build against newer kernels (e.g. 7.3): upstream refactored clevo_acpi
# from the legacy `struct acpi_driver` to a `platform_driver` to stay
# compatible, starting with v4.24.0.
#
# That fix already landed on nixpkgs master (4.20.1 -> 4.25.0):
# https://github.com/NixOS/nixpkgs/pull/577948
#
# ...and a backport PR is open against release-26.05, just not merged yet:
# https://github.com/NixOS/nixpkgs/pull/583561
#
# Once the channel catches up, drop this overlay and ./tuxedo-drivers/.
#
# This driver package is still needed - it's not superseded by anything in
# the mainline kernel. TUXEDO has only upstreamed one narrow piece so far
# (drivers/platform/x86/tuxedo/nb04/wmi_ab.c - keyboard-backlight-only, for
# "NB04" board notebooks), and says as much in their README:
# https://github.com/tuxedocomputers/tuxedo-drivers#regarding-upstreaming-of-tuxedo-drivers
# Fn-keys, fan control and the TUXEDO Control Center I/O driver this host
# relies on (nixos-hardware's gen9-amd module sets `hardware.tuxedo-drivers.enable`)
# remain out-of-tree.
final: prev:
let
  minVersion = "4.25.0";
  minVersionHash = "sha256-AER+JPl3lem1OFV51VdOZAnr3Uy1BFSpEJNrE+shYis=";
in
{
  linuxPackages_latest = prev.linuxPackages_latest.extend (
    lpFinal: lpPrev: {
      tuxedo-drivers =
        if prev.lib.versionAtLeast lpPrev.tuxedo-drivers.version minVersion then
          # Throw exception, once this overlay becomes superfluous.
          throw "Overlay not required anymore - use upstream version from channel!"
        else
          lpPrev.tuxedo-drivers.overrideAttrs (old: {
            version = minVersion;
            src = prev.fetchFromGitLab {
              group = "tuxedocomputers";
              owner = "development/packages";
              repo = "tuxedo-drivers";
              rev = "v${minVersion}";
              hash = minVersionHash;
            };
            patches = [ ./tuxedo-drivers/no-cp-usr.patch ];
            postInstall = ''
              substituteInPlace files/usr/lib/udev/rules.d/* \
                --replace-quiet "/bin/bash" "${prev.lib.getExe prev.bash}" \
                --replace-quiet "/bin/sh" "${prev.lib.getExe prev.bash}"

              install -Dm0644 \
                -t "$out/etc/udev/rules.d" \
                files/usr/lib/udev/rules.d/*
            '';
          });
    }
  );
}
