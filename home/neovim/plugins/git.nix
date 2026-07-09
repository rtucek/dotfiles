{ ... }:
{
  programs.nixvim = {
    opts = {
      # Set signcolumn to be always present.
      # This way, we don't have awkward flash jumps.
      signcolumn = "yes";
    };

    plugins = {
      # see https://github.com/airblade/vim-gitgutter/
      gitgutter = {
        enable = true;
        recommendedSettings = true;
        settings = {
          sign_added = "+";
          sign_removed = "-";
          sign_modified = "±";
          sign_modified_removed = "±";
        };
      };

      # see https://github.com/tpope/vim-fugitive/
      fugitive = {
        enable = true;
      };
    };
  };
}
