{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.git =
    let
      bash = "${lib.getExe pkgs.bash}";
      delta = "${lib.getExe pkgs.delta}";
      diff = "${lib.getBin pkgs.diffutils}/bin/diff";
      git = "${lib.getExe pkgs.git}";
      grep = "${lib.getExe pkgs.gnugrep}";
      head = "${lib.getBin pkgs.coreutils-full}/bin/head";
      nvim = "${config.programs.nixvim.build.package}/bin/nvim";
      sed = "${lib.getExe pkgs.gnused}";
    in
    {
      enable = true;
      package = pkgs.gitFull;

      ignores = [
        "/.idea/"
        "*.sublime-project"
        "*.sublime-workspace"
        "*.swp"
        "*~"
        ".DS_Store"
        ".tags"
        ".tags.lock"
        ".tags.temp"
        "/.tmuxinator.yml"
        "Session.vim"
      ];

      maintenance.enable = true;

      # # To be set by the importer
      # signing = {
      #   format = "openpgp";
      #   key = "0x49593BD010DE4723";
      #   signByDefault = true;
      # };

      settings = {
        # To be set by the importer
        # user = {
        #   name = "Rudolf Tucek";
        #   email = "tucek.rudolf@gmail.com";
        # };

        core = {
          autocrlf = "input";
          editor = nvim;
          pager = delta;
        };

        alias = {
          fork-point = "!${bash} -c '${diff} -u <(${git} rev-list --first-parent \"\${1:-master}\") <(${git} rev-list --first-parent \"\${2:-HEAD}\") | ${sed} -ne \"s/^ //p\" | ${head} -1' -";
          lg = "lg1";
          lg1 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset) %C(bold yellow)%d%C(reset)' --branches --remotes --tags";
          lg2 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset) %C(bold yellow)%d%C(reset)' --all";
          patch = "!${git} --no-pager diff --no-color";
          permission-reset = "!${git} diff -p -R | ${grep} -E \"^(diff|(old|new) mode)\" | ${git} apply";
        };

        commit = {
          verbose = true;
          cleanup = "scissors";
        };

        # To be set by the importer
        # tag = {
        #   forceSignAnnotated = true;
        # };

        format = {
          coverFromDescription = "auto";
          coverLetter = "auto";
          signOff = "true";
        };

        fetch = {
          prune = true;
        };

        prune = {
          rebase = "merges";
        };

        pull = {
          rebase = "merges";
        };

        push = {
          default = "simple";
        };

        rebase = {
          autoStash = true;
        };

        merge = {
          autoStash = true;
          conflictstyle = "diff3";
          ff = false;
          log = true;
          tool = "nvimdiff";
        };

        mergetool = {
          prompt = true;
        };

        "mergetool \"nvimdiff\"" = {
          cmd = "${nvim} -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
        };

        color = {
          ui = true;
        };

        diff = {
          colorMoved = "default";
          renames = "copies";
          tool = "nvimdiff";
        };

        difftool = {
          prompt = true;
        };

        "difftool \"nvimdiff\"" = {
          cmd = "${nvim} -d $LOCAL $REMOTE -c '$wincmd w' -c 'wincmd L'";
        };

        delta = {
          color-only = true;
          hunk-header-style = "syntax";
          line-numbers = true;
          minus-style = "syntax \"#3f0001\"";
          # side-by-side = true;
          syntax-theme = "Monokai Extended";
          whitespace-error-style = "normal";
        };

        interactive = {
          diffFilter = "${delta} --color-only --hunk-header-style raw";
        };

        "color \"diff\"" = {
          commit = "yellow bold";
          frag = "magenta bold";
          meta = "11";
          new = "green bold";
          old = "red bold";
          # whitespace = "red reverse";
        };
      };
    };
}
