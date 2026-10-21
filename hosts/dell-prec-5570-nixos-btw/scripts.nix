{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Bin utils
  expect = "${lib.getExe pkgs.expect}";
  gpg = "${lib.getExe pkgs.gnupg}";
  keepassxc = "${lib.getExe pkgs.keepassxc}";
  keepassxc-cli = "${lib.getBin pkgs.keepassxc}/bin/keepassxc-cli";
  pkill = "${lib.getBin pkgs.procps}/bin/pkill";
  sleep = "${lib.getBin pkgs.coreutils}/bin/sleep";
  wl-copy = "${lib.getBin pkgs.wl-clipboard}/bin/wl-copy";

  # Location of keepass file
  keepassFile = "${config.home-manager.users.rtucek.home.homeDirectory}/projects/wa-tools/keys/WattAnalytics.kdbx";

  # keepass-pw copies the keepass password to the clipboard
  keepass-pw = pkgs.writeShellScriptBin "keepass-pw" ''
    ${gpg} --quiet --decrypt ${./keepass.asc} | ${wl-copy}
  '';

  # (Re-)start keepassxc UI with an unlocked keyfile ready to use.
  keepass-ui = pkgs.writeShellScriptBin "keepass-ui" ''
    ${pkill} keepassxc 2>/dev/null
    ${sleep} 1
    (${gpg} --quiet --decrypt ${./keepass.asc} | ${keepassxc} --pw-stdin ${keepassFile} &> /dev/null &)
  '';

  # keepass-cli open the interactive keepassxc CLI with an unlocked keyfile ready to use.
  keepass-cli = pkgs.writeShellScriptBin "keepass-cli" ''
    ${expect} ${expectScript}
  '';
  # Expect script for unlocking the keyfile without the user's interaction.
  expectScript = pkgs.writeTextFile {
    name = "keepass-cli.exp";
    executable = false;
    text = ''
      set PASS [exec ${gpg} --quiet --decrypt ${./keepass.asc}]

      spawn ${keepassxc-cli} open ${keepassFile}
      expect "Enter password to unlock"
      send -- "$PASS\r"
      interact
    '';
  };
in
{
  config.home-manager.users.rtucek = {
    home.packages = [
      keepass-pw
      keepass-ui
      keepass-cli
    ];
  };
}
