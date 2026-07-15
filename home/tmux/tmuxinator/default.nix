{ ... }:
{
  imports = [
    ./home.nix
  ];

  programs.tmux.tmuxinator = {
    enable = true;
  };
}
