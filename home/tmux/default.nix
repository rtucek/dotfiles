{ pkgs, lib, ... }:
{
  imports = [
    ./tmuxinator
  ];

  programs.tmux = {
    enable = true;
    sensibleOnTop = true;

    secureSocket = true;

    prefix = "C-Space";
    keyMode = "vi";

    mouse = true;
    baseIndex = 1;
    clock24 = true;

    extraConfig = ''
      # Set ability to capture on start and restore on exit window data when
      # running an application
      setw -g alternate-screen on

      # Scrolling
      set -g terminal-overrides 'xterm*:smcup@:rmcup@'

      # Cursor shape
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

      # Pass-on focus events to appliations
      set -g focus-events on

      # Ensure colors are set properly
      set-option -sa terminal-overrides ',rxvt-unicode-256color:RGB' # urxvt
      set-option -sa terminal-overrides ',xterm-256color:RGB' # terminator

      # Set window title
      set-option -g set-titles on
      set-option -g set-titles-string "#S: #{pane_current_command}"

      # Don't set the clipboard via escape sequence
      set-option -s set-clipboard off



      ### GENERAL KEY BINDINGS ###
      # Clock mode (default binding "t" gets overridden via tmux-sessionist plugin)
      bind T clock-mode

      # Move back and forward
      bind -r 'C-p' previous-window
      bind -r 'C-n' next-window

      # Split windows
      bind 'c' new-window -c '#{pane_current_path}'



      ### TWEAK UI ###
      # Derived from
      # https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/

      # Re-enumerate windows on close
      set-option -g renumber-windows on
      # Re-name windows, based on current program
      setw -g automatic-rename on


      ## Status bar design
      # Status line
      set -g status-justify left
      set -g status-interval 1


      # Messaging
      set -g message-style bold,fg=colour232,bg=colour166
      set -g message-command-style fg=blue,bg=black


      # Info on left (I don't have a session display for now)
      set -g status-left '''


      # Loud or quiet?
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity off
      set-option -g bell-action none


      # The modes
      setw -g clock-mode-colour colour135
      setw -g mode-style bold,fg=colour196,bg=colour238


      # The panes
      set -g pane-border-style bg=colour235,fg=colour238
      set -g pane-active-border-style bg=colour236,fg=colour51


      # The statusbar
      set -g status-position bottom
      set -g status-bg colour234
      set -g status-fg colour137
      set -g status-style dim
      set -g status-right '#[fg=colour233,bg=colour241,bold] %Y-%m-%d #[fg=colour233,bg=colour245,bold] %H:%M:%S '
      set -g status-right-length 100
      set -g status-left-length 20

      setw -g window-status-current-style fg=colour81,bg=colour238,bold
      setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '

      setw -g window-status-style fg=colour138,bg=colour235,none
      setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

      setw -g window-status-bell-style bold,fg=colour255,bg=colour1
    '';

    plugins =
      let
        wl-copy = "${lib.getBin pkgs.wl-clipboard}/bin/wl-copy";
      in
      with pkgs;
      [
        tmuxPlugins.copycat
        tmuxPlugins.open
        tmuxPlugins.pain-control
        tmuxPlugins.sessionist
        {
          plugin = tmuxPlugins.yank;
          extraConfig = ''
            set -g @override_copy_command '${wl-copy}'
          '';
        }
        tmuxPlugins.jump
      ];
  };
}
