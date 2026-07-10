{ ... }:
{
  programs.nixvim = {
    plugins = {
      # see https://github.com/tpope/vim-surround/
      vim-surround = {
        enable = true;
      };

      # see https://github.com/nvim-mini/mini.indentscope/
      mini-indentscope = {
        enable = true;
      };
    };
  };
}
