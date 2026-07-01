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
      };

      # see https://github.com/tpope/vim-fugitive/
      fugitive = {
        enable = true;
      };
    };
  };
}
