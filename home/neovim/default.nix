{ ... }:
{
  imports = [
    ./settings.nix

    ./languages
  ];

  programs.nixvim = {
    enable = true;
  };
}
