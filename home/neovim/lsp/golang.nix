{
  programs.nixvim = {
    dependencies.go.enable = true;

    lsp.servers = {
      # see https://github.com/golang/tools/tree/master/gopls
      gopls = {
        enable = true;
      };
    };
  };
}
