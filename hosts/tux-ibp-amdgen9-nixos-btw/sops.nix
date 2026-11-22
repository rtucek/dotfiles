{ config, pkgs, ... }:
{
  home-manager.users.rtucek = {
    sops = {
      secrets = {
        gh_token = {
          sopsFile = ../../secrets/private/hosts/tux-ibp-amdgen9-nixos-btw.yaml;
        };
      };
      templates = {
        nixConf = {
          # Same token, we borrow from gh
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
      };
    };
  };
}
