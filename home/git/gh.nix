{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = [
    pkgs.gh
  ];

  programs.gh = {
    enable = true;

    settings =
      let
        brave = "${lib.getExe pkgs.brave}";
        less = "${lib.getExe pkgs.less}";
        nvim = "${config.programs.nixvim.build.package}/bin/nvim";
      in
      {
        version = 1;
        git_protocol = "ssh";
        editor = nvim;
        prompt = "enabled";
        prefer_editor_prompt = "enabled";
        pager = less;
        # http_unix_socket = "";
        browser = brave;
        color_labels = "enabled";
        accessible_colors = "disabled";
        accessible_prompter = "disabled";
        spinner = "enabled";
      };

    gitCredentialHelper.enable = false;
  };
}
