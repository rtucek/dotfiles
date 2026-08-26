{ config, pkgs, ... }:
{
  home-manager.users.rtucek = {
    sops = {
      secrets = {
        ssh_private_key = {
          key = "ssh/private_key";
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.ssh/id_ed25519";
        };
        ssh_public_key = {
          key = "ssh/public_key";
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.ssh/id_ed25519.pub";
        };
        gh_token = { };
        do_token = { };
      };
      templates = {
        nixConf = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.config/nix/nix.conf";
          content = ''
            access-tokens = github.com=${config.home-manager.users.rtucek.sops.placeholder.gh_token}
          '';
        };
        ghHostsConf = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.config/gh/hosts.yml";
          file = (pkgs.formats.yaml { }).generate "" {
            "github.com" = {
              users = {
                rtucek = {
                  oauth_token = config.home-manager.users.rtucek.sops.placeholder.gh_token;
                };
              };
              git_protocol = "ssh";
              oauth_token = config.home-manager.users.rtucek.sops.placeholder.gh_token;
              user = "rtucek";
            };
          };
        };
        doConf = {
          path = "${config.home-manager.users.rtucek.home.homeDirectory}/.config/doctl/config.yaml";
          file = (pkgs.formats.yaml { }).generate "" {
            access-token = config.home-manager.users.rtucek.sops.placeholder.do_token;
          };
        };
      };
    };
  };
}
