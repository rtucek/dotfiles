{ config, ... }:
{
  imports = [
    ./golang.nix
    ./nix.nix
    ./sh.nix
  ];

  programs.nixvim = {
    lsp =
      let
        nixvimLua = config.lib.nixvim.mkRaw;
      in
      {
        inlayHints.enable = true;
        keymaps = [
          {
            key = "gd";
            lspBufAction = "definition";
          }
          {
            key = "gD";
            lspBufAction = "references";
          }
          {
            key = "gt";
            lspBufAction = "type_definition";
          }
          {
            key = "gi";
            lspBufAction = "implementation";
          }
          {
            key = "K";
            lspBufAction = "hover";
          }
          {
            action = nixvimLua "function() vim.diagnostic.jump({ count=-1, float=true }) end";
            key = "<leader>k";
          }
          {
            action = nixvimLua "function() vim.diagnostic.jump({ count=1, float=true }) end";
            key = "<leader>j";
          }
          {
            action = "<CMD>LspStop<Enter>";
            key = "<leader>lx";
          }
          {
            action = "<CMD>LspStart<Enter>";
            key = "<leader>ls";
          }
          {
            action = "<CMD>LspRestart<Enter>";
            key = "<leader>lr";
          }
          {
            action = nixvimLua "require('telescope.builtin').lsp_definitions";
            key = "gd";
          }
          {
            action = "<CMD>Lspsaga hover_doc<Enter>";
            key = "K";
          }
        ];
      };
  };
}
