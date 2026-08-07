{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim

    ./keybindings.nix
    ./lsp
    ./plugins
    ./settings.nix
  ];

  programs.nixvim = {
    enable = true;
  };
}
