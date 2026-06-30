{ ... }:
{
  imports = [
    ./keybindings.nix
    ./lsp
    ./plugins
    ./settings.nix
  ];

  programs.nixvim = {
    enable = true;
  };
}
