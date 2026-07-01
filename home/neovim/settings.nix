{ ... }:
{
  programs.nixvim = {
    defaultEditor = true;
    vimdiffAlias = true;
    enableMan = true;

    # Clip-board syncing
    waylandSupport = true;
    clipboard.register = "unnamedplus";

    # Language providers
    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;

    editorconfig = {
      enable = true;
    };

    colorschemes = {
      onedark = {
        enable = true;
      };
    };

    opts = {
      #  -----GENERAL-----
      encoding = "UTF-8";
      backspace = "indent,eol,start";

      # Set language for spell check
      spell = true;

      # Fixing tabs and indentation
      autoindent = true;
      copyindent = true;
      expandtab = false;
      preserveindent = true;
      softtabstop = 0;

      # Case-insensitive tab completion
      wildignorecase = true;

      # Make scrolling faster and more accurate
      ttyfast = true;

      # Refresh buffer automatically
      autoread = true;

      # Add mouse support
      mouse = "a";

      # Suppress warning when changing FROM unsaved buffer
      hidden = true;

      # Demand explicit confirmation when closing unsaved buffers
      confirm = true;

      # Deactivate folding
      foldenable = false;
      foldmethod = "syntax";

      # Don't use swapfiles
      swapfile = false;

      # Optimize search
      incsearch = true;
      hlsearch = true;
      ignorecase = true;
      smartcase = true;

      # -----VISUAL-----

      # Syntax highlighting
      syntax = "enable";

      # Always display tabline
      showtabline = 2;

      # Highlight line of the current cursor
      cursorline = true;

      # Show column length
      ruler = true;

      # Show line numbers
      number = true;
    };

    localOpts = {
      # Set language for spell check
      spelllang = "en_us";
    };
  };
}
