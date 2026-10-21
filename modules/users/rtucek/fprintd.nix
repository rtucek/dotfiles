{ config, lib, ... }:
let
  cfg = config.rtucek.auth.fprintd;
in
{
  options.rtucek.auth.fprintd = {
    enable = lib.options.mkEnableOption "Enable Fingerprint scanner";
  };

  config = lib.mkIf cfg.enable {
    # Add fprintd
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;

    # Patch hyprlock for allowing login via fingerprint.
    home-manager.users.rtucek.programs.hyprlock.settings = {
      auth.fingerprint.enabled = true;
      input-field = {
        placeholder_text = "$FPRINTPROMPT";
        fail_text = "$FPRINTFAIL";
      };
    };
  };
}
