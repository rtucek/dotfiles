{ ... }:
{
  security = {
    audit = {
      enable = true;

      rules = [
        # Host key
        "-a always,exit -F arch=b32 -F path=/secrets -F key=secrets_dir_host"
        "-a always,exit -F arch=b64 -F path=/secrets -F key=secrets_dir_host"

        # User sops dir
        "-a always,exit -F arch=b64 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user"
        "-a always,exit -F arch=b32 -F path=/home/rtucek/.config/sops/age/keys.txt -F perm=rwa -F key=secrets_dir_user"
      ];
    };

    auditd = {
      enable = true;
    };
  };
}
