{ config, lib, ... }:
let
  nvim = "${config.home-manager.users.rtucek.programs.nixvim.build.package}/bin/nvim";

  projects = [
    (lib.nameValuePair "wa-cloudcore" "~/projects/wa-cloudcore")
    (lib.nameValuePair "wa-database-schema" "~/projects/database-schema")
    (lib.nameValuePair "wa-edge" "~/projects/wa-edge")
    (lib.nameValuePair "wa-tools" "~/projects/wa-tools")
    (lib.nameValuePair "wactl" "~/projects/wactl")
    (lib.nameValuePair "wse-web-site" "~/projects/wse-web-site")
    (lib.nameValuePair "wa-eda-adapter" "~/projects/wa-eda-adapter")
    (lib.nameValuePair "wa-eda-adapter-v2" "~/projects/wa-eda-adapter-v2")
    (lib.nameValuePair "wa-partner-portal" "~/projects/wa-partner-portal")
  ];
in
{
  rtucek.tmuxinator.projects = lib.listToAttrs (
    map (
      p:
      lib.nameValuePair p.name {
        name = p.name;
        root = p.value;
        startup_window = "git";
        windows = [
          { editor = nvim; }
          { git = [ "" ]; }
        ];
      }
    ) projects
  );
}
