{
  programs.fzf = {
    enable = true;

    tmux = {
      enableShellIntegration = true;
    };

    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
