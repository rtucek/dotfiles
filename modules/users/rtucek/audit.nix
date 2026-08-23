{ pkgs, ... }:
{
  # Audit access to age key
  #
  # Note: we can't use `security.audit.rules`, as these rules will be merged
  # into systemd's `audit-rules-nixos.service` unit, which runs immediately
  # after sysinit.target.
  #
  # However, this is too early, as at this time, LVM hasn't yet mounted the
  # /home directory and therefore, fails to load the unit.
  #
  # The workaround is to load rules, referencing paths in /home in a separate systemd unit,
  # triggered by reaching the `home.mount` target.
  systemd.services.audit-rules-nixos-home-age =
    let
      auditrules = pkgs.writeTextFile {
        name = "audit-home.rules";
        text = ''
          -D -k secrets_dir_user
          -a always,exit -F arch=b64 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user
          -a always,exit -F arch=b32 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user
        '';
      };
    in
    {
      description = "Load Audit Rules after LVM mount";
      wantedBy = [ "home.mount" ];
      after = [ "home.mount" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.audit}/bin/auditctl -R ${auditrules}";
      };
    };
}
