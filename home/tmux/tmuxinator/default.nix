{ ... }:
{
  imports = [
    ./dotfiles.nix
    ./home.nix
  ];

  programs.tmux.tmuxinator = {
    enable = true;
  };
}
