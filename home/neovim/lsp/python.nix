{
  programs.nixvim = {
    dependencies.python3.enable = true;

    lsp.servers = {
      # see https://github.com/microsoft/pyright
      pyright = {
        enable = true;
      };

      # see https://github.com/astral-sh/ruff
      ruff = {
        enable = true;
      };
    };

    # ruff's own LSP implements formatting, so no none-ls source is needed
    plugins.lsp-format.lspServersToEnable = [
      "ruff"
    ];
  };
}
