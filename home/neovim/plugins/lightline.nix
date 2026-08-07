{ ... }:
{
  programs.nixvim = {
    opts = {
      # Always leave space for lightline
      laststatus = 2;

      # Don't show mode as we'll have lightline display it
      showmode = false;
    };

    plugins = {
      # Install fugitive, so we have lightline integration.
      #
      # see https://github.com/tpope/vim-fugitive/
      fugitive = {
        enable = true;
      };

      # See https://github.com/itchyny/lightline.vim/
      lightline = {
        enable = true;

        settings = {
          colorscheme = "one";

          active = {
            left = [
              [
                "mode"
                "paste"
              ]
              [
                "gitbranch"
                "readonly"
              ]
            ];

            right = [
              [ "lineinfo" ]
              [
                "fileformat"
                "fileencoding"
                "filetype"
              ]
            ];
          };

          component = {
            lineinfo = "%l>%c";
          };

          component_function = {
            gitbranch = "FugitiveHead";
          };
        };
      };
    };
  };
}
