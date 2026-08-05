{ lib, ... }:
{
  programs.yubikey-manager.enable = true;

  # We will use GPG's scdaemon instead.
  services.pcscd.enable = lib.mkForce false;

  # Add udev rules for smart cards
  hardware.gpgSmartcards.enable = true;

  # With regards to SSH authentication, it's preferred to use GPG over the
  # "traditional" SSH agent.
  # As such, we're explicitly disabling openssh's ssh agent.
  programs.ssh.startAgent = false;
}
