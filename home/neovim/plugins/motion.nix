{ config, ... }:
{
  programs.nixvim = {
    keymaps =
      let
        nixvimLua = config.lib.nixvim.mkRaw;
      in
      [
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader><leader>s";
          action = nixvimLua ''
            function()
              local hop = require('hop')
              local directions = require('hop.hint').HintDirection

              hop.hint_char1({
                direction = directions.AFTER_CURSOR
              })
            end
          '';
          options = {
            desc = "Quick jump after the cursor via hop motion plugin";
            silent = true;
          };
        }
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader><leader>S";
          action = nixvimLua ''
            function()
              local hop = require('hop')
              local directions = require('hop.hint').HintDirection

              hop.hint_char1({
                direction = directions.BEFORE_CURSOR
              })
            end
          '';
          options = {
            desc = "Quick jump before the cursor via hop motion plugin";
            silent = true;
          };
        }
      ];

    plugins = {
      # see https://github.com/smoka7/hop.nvim/
      hop = {
        enable = true;
      };
    };
  };
}
