{ config, ... }:
{
  programs.nixvim = {
    keymaps = [
      {
        action = ":UndotreeToggle<cr>";
        key = "<leader><leader>u";
        mode = [ "n" ];
        options = {
          silent = true;
        };
      }
    ];

    opts =
      let
        nixvimLua = config.lib.nixvim.mkRaw;
      in
      {
        undodir = nixvimLua ''
          vim.fn.expand('~') .. '/.undodir'
        '';
        undofile = true;
      };

    plugins = {
      # see https://github.com/mbbill/undotree/
      undotree = {
        enable = true;
      };
    };
  };
}
