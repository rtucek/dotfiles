{ ... }:
{
  programs.nixvim = {
    plugins = {
      # see https://github.com/tpope/vim-surround/
      vim-surround = {
        enable = true;
      };
    };
  };
}
