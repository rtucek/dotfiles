{ config, ... }:
let
  nvim = "${config.home-manager.users.rtucek.programs.nixvim.build.package}/bin/nvim";
in
{
  home-manager.users.rtucek.programs.tmux.tmuxinator.projects = {
    wa-cloudcore = {
      name = "wa-cloudcore";
      root = "~/projects/wa-cloudcore";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wa-database-schema = {
      name = "wa-database-schema";
      root = "~/projects/database-schema";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wa-edge = {
      name = "wa-edge";
      root = "~/projects/wa-edge";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wa-tools = {
      name = "wa-tools";
      root = "~/projects/wa-tools";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wactl = {
      name = "wactl";
      root = "~/projects/wactl";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wse-web-site = {
      name = "wse-web-site";
      root = "~/projects/wse-web-site";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wa-eda-adapter = {
      name = "wa-eda-adapter";
      root = "~/projects/wa-eda-adapter";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };

    wa-eda-adapter-v2 = {
      name = "wa-eda-adapter-v2";
      root = "~/projects/wa-eda-adapter-v2";

      startup_window = "git";

      windows = [
        {
          editor = nvim;
        }
        {
          git = [ "" ];
        }
      ];
    };
  };
}
