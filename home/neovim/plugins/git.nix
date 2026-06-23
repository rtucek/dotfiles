{ ... }:
{
  programs.nixvim = {
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
