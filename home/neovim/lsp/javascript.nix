{
  programs.nixvim = {
    dependencies.nodejs.enable = true;

    lsp.servers = {
      # see https://github.com/typescript-language-server/typescript-language-server
      ts_ls = {
        enable = true;
      };

      # see https://github.com/eslint/eslint
      eslint = {
        enable = true;
      };
    };

    plugins.none-ls.sources.formatting = {
      # see https://github.com/prettier/prettier
      prettier.enable = true;
    };
  };
}
