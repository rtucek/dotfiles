{ config, ... }:
{
  programs.nixvim =
    let
      nixvimLua = config.lib.nixvim.mkRaw;
    in
    {
      keymaps = [
        {
          # Quick edit ~/.vimrc
          action = ":e $MYVIMRC<CR>";
          key = "<leader>ev";
          mode = [ "n" ];
          options = {
            silent = true;
          };
        }

        {
          # Toggle Spell check
          action = nixvimLua ''
            function()
              vim.opt.spell = not vim.opt.spell:get()
              print(string.format("spellcheck=%s", vim.opt.spell:get()))
            end
          '';
          key = "<leader>s";
          mode = [ "n" ];
          options = {
            noremap = true;
          };
        }

        # Tab navigation
        {
          # Create new tab
          action = ":tabnew<space>";
          key = "<leader>tab";
          mode = [ "n" ];
          options = {
            noremap = true;
          };
        }
        {
          # Close tab (keep buffer intact)
          action = ":tabclose<CR>";
          key = "<leader>w";
          mode = [ "n" ];
          options = {
            silent = true;
            noremap = true;
          };
        }
        {
          # Close tab (keep buffer intact)
          action = ":tabnew %<CR>:tabprevious<CR>";
          key = "<leader>tabthis";
          mode = [ "n" ];
          options = {
            silent = true;
            noremap = true;
          };
        }

        # Better navigation with wrapped lines
        {
          action = "gk";
          key = "k";
          mode = [ "n" ];
          options = {
            noremap = true;
          };
        }
        {
          action = "gj";
          key = "j";
          mode = [ "n" ];
          options = {
            noremap = true;
          };
        }
        {
          action = "g0";
          key = "0";
          mode = [ "n" ];
          options = {
            noremap = true;
          };
        }
        {
          action = "g$";
          key = "$";
          mode = [ "n" ];
          options = {
            noremap = true;
          };
        }

        {
          # Don't yank selected text after overwriting via paste
          action = "\"_dP";
          key = "p";
          mode = [ "v" ];
          options = {
            noremap = true;
            silent = true;
          };
        }

        # Move blocks of selected lines up and down in visual mode
        {
          action = ":m '>+1<CR>gv";
          key = "<C-J>";
          mode = [ "v" ];
          options = {
            noremap = true;
            silent = true;
          };
        }
        {
          action = ":m '<-2<CR>gv";
          key = "<C-K>";
          mode = [ "v" ];
          options = {
            noremap = true;
            silent = true;
          };
        }

        # In- and  un-indent lines while also preserving selection
        {
          action = "<<CR>gv";
          key = "<";
          mode = [ "v" ];
          options = {
            noremap = true;
            silent = true;
          };
        }
        {
          action = "><CR>gv";
          key = ">";
          mode = [ "v" ];
          options = {
            noremap = true;
            silent = true;
          };
        }

        {
          # Toggle relative line numbers
          action = nixvimLua ''
            function()
              vim.opt.relativenumber = not vim.opt.relativenumber:get()
              print(string.format("relativenumber=%s", vim.opt.relativenumber:get()))
            end
          '';
          key = "<leader>r";
          mode = [
            "n"
            "v"
          ];
          options = {
            noremap = true;
            silent = true;
          };
        }

        {
          # Toggle relative line numbers
          action = nixvimLua ''
            function()
              vim.opt.foldenable = not vim.opt.foldenable:get()
              print(string.format("foldenable=%s", vim.opt.foldenable:get()))
            end
          '';
          key = "<leader>f";
          mode = [
            "n"
            "v"
          ];
          options = {
            noremap = true;
            silent = true;
          };
        }

        ## Leave commented out for now, since it does not work with sudo-rs
        # {
        #   # Sudo write
        #   action = "w !sudo -S tee > /dev/null %";
        #   key = "w!!";
        #   mode = [ "c" ];
        # }
      ];
    };
}
