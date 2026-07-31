{ lib, pkgs, ... }:
{
  # pcscd will be used as the authoritative daemon, interacting with smartcards
  # like Yubikeys.
  #
  # However, pcscd does try to acquirer an exclusive lock on a detected
  # smartcard and so do other daemons (e.g. scdaemon from GPG).
  # As such, we have to make sure that other daemons work with pcscd together.
  #
  # see https://github.com/OpenSC/OpenSC/wiki/GnuPG-and-OpenSC
  services.pcscd = {
    enable = true;
  };
  # Add udev rules for smart cards
  hardware.gpgSmartcards.enable = true;

  # With regards to SSH authentication, it's preferred to use GPG over the
  # "traditional" SSH agent.
  # As such, we're explicitly disabling openssh's ssh agent.
  programs.ssh.startAgent = false;
  # Set SSH_AUTH_SOCK ENV globally for all shells.
  # This allows ssh clients to find the proper socket to get authentication
  # credentials from.
  environment.shellInit =
    let
      gpgconf = "${lib.getBin pkgs.gnupg}/bin/gpgconf";
    in
    ''
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(${gpgconf} --list-dirs agent-ssh-socket)
    '';
}
