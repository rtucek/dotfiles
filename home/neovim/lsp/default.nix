{ pkgs, ... }:
{
  imports = [
    ./golang.nix
    ./nix.nix
    # ./sh.nix
  ];

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      ultisnips
    ];

    autoGroups = {
      format_on_save = {
        clear = true;
      };
    };
    autoCmd = [
      {
        event = [ "BufWritePre" ];
        buffer = 0;
        command = "lua vim.lsp.buf.format()";
        desc = "Auto-format on save";
        group = "format_on_save";
      }
    ];

    # Required for the `lsp-lines` plugin
    diagnostic = {
      settings = {
        virtual_lines = true;
        virtual_text = false;
      };
    };

    highlight = {
      LspSignatureActiveParameter = {
        fg = "#282c34";
        bg = "#61afef";
      };
    };

    plugins = {
      # see https://github.com/neovim/nvim-lspconfig/
      lsp = {
        enable = true;
        keymaps = {
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
          };
        };
      };

      # see https://git.sr.ht/~whynothugo/lsp_lines.nvim
      lsp-lines = {
        enable = true;
      };

      # see https://github.com/ray-x/lsp_signature.nvim/
      lsp-signature = {
        enable = true;
        settings = {
          hint_enable = false;
        };
      };

      # see https://github.com/hrsh7th/nvim-cmp
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "ultisnips"; }
          ];

          snippet = {
            expand = ''
              function(args)
                -- ultisnips
                vim.fn["UltiSnips#Anon"](args.body)
              end
            '';
          };

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };
      # see https://github.com/quangnguyen30192/cmp-nvim-ultisnips/
      cmp-nvim-ultisnips = {
        enable = true;
      };
    };
  };
}
