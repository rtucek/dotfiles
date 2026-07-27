{ ... }:
{
  security = {
    audit = {
      enable = true;

      rules = [
        # Host key
        "-a always,exit -F arch=b32 -F path=/secrets -F key=secrets_dir_host"
        "-a always,exit -F arch=b64 -F path=/secrets -F key=secrets_dir_host"
      ];
    };

    auditd = {
      enable = true;
    };
  };
}
