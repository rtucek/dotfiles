{
  programs.nixvim = {
    lsp.servers = {
      nil_ls = {
        enable = true;
      };
      nixd = {
        enable = true;
      };
    };

    plugins.none-ls.sources = {
      formatting = {
        nixfmt.enable = true;
      };
    };
  };
}
