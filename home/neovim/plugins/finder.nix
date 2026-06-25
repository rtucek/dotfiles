{ ... }:
{
  programs.nixvim = {
    dependencies = {
      ripgrep.enable = true;
    };
    plugins = {
      # see https://github.com/nvim-telescope/telescope.nvim
      telescope = {
        enable = true;
        keymaps = {
          # Fuzzy search
          "<C-P>" = {
            action = "find_files";
            options = {
              desc = "Search files";
            };
          };
          "<leader>p" = {
            action = "git_files";
            options = {
              desc = "Search files via `git ls-files` (respects .gitignore)";
            };
          };
          "<leader>buf" = {
            action = "buffers";
            options = {
              desc = "Search buffers";
            };
          };
          "<leader>lin" = {
            action = "current_buffer_fuzzy_find";
            options = {
              desc = "Search for lines in current buffer";
            };
          };
          "<leader>tag" = {
            action = "current_buffer_tags";
            options = {
              desc = "Search by tags in current buffer";
            };
          };

          # Git integration
          "<leader>gitstatus" = {
            action = "git_status";
            options = {
              desc = "List current changes per file with diff preview";
            };
          };
          "<leader>gitbranch" = {
            action = "git_branches";
            options = {
              desc = "List current branches";
            };
          };
          "<leader>gitstash" = {
            action = "git_stash";
            options = {
              desc = "List stash item";
            };
          };
          "<leader>gitcom" = {
            action = "git_commits";
            options = {
              desc = "List git commits with diff preview; checkout via <CR>";
            };
          };
          "<leader>gitbcom" = {
            action = "git_bcommits";
            options = {
              desc = "List git commits with diff preview of current file only; checkout via <CR>";
            };
          };
          "<leader>a" = {
            action = "live_grep";
            options = {
              desc = "Search for string by using ripgrep (respecting .gitignore)";
            };
          };

          # LSP integration
          "gd" = {
            action = "lsp_definitions";
            optons = {
              desc = "Goto definition under the cursor";
            };
          };
          "gr" = {
            action = "lsp_references";
            options = {
              desc = "Find references under the cursor";
            };
          };
          "gi" = {
            action = "lsp_implementations";
            options = {
              desc = "Find implementations under the cursor";
            };
          };
        };
      };
    };
  };
}
