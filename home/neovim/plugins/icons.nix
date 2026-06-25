{ ... }:
{
  programs.nixvim = {
    plugins = {
      # see https://github.com/nvim-tree/nvim-web-devicons
      #
      # web-devicons provides Nerd Font icons, used by several plugins (e.g.
      # CHADtree and telescope, just to name a few...).
      web-devicons = {
        enable = true;
        settings = {
          color_icons = true;
          strict = true;
        };
      };
    };
  };
}
