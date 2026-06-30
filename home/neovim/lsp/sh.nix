{
  programs.nixvim = {
    lsp.servers = {
      bashls = {
        enable = true;
      };
      fish_lsp = {
        enable = true;
      };
    };
  };
}
