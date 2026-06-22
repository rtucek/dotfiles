{ ... }:
{
  imports = [
    ./keybindings.nix
    ./languages
    ./settings.nix
  ];

  programs.nixvim = {
    enable = true;
  };
}
