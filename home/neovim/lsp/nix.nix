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
  };
}
