{ ... }:
{
  imports = [
    ./keybindings.nix
    ./languages
    ./plugins
    ./settings.nix
  ];

  programs.nixvim = {
    enable = true;
  };
}
