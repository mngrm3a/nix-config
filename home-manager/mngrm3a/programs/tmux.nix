{
  config,
  lib,
  pkgs,
  ...
}:
{
  # integrations
  programs.fzf.tmux.enableShellIntegration = true;
  programs.fzf.tmux.shellIntegrationOptions = [ ];

  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = gruvbox;
        extraConfig = "set -g @tmux-gruvbox 'dark' # or 'light'";
      }
      { plugin = tmux-fzf; }
    ];
    # This needs to be set or the homemanager module will default to screen.
    terminal = "tmux-256color";
    extraConfig = ''
      # Automatically rename windows based on the running program
      set-window-option -g automatic-rename on

      # Allow tmux to set terminal/tab titles dynamically
      set-option -g set-titles on

      # Monitor all windows for activity and alert if something changes
      setw -g monitor-activity on

      # Ensure true-color support for your terminal ($TERM)
      set -ag terminal-overrides ",$TERM:Tc"

      # see: https://github.com/tmux-plugins/tmux-sensible/issues/74
      # Required due to sensible-tmux on macOS: without unsetting, tmux may default to sh
      # instead of the configured shell. This allows sensible-tmux's reattach-to-user-namespace
      # logic to correctly launch your preferred shell.
      #
      # Note: On modern macOS versions (10.12 Sierra and later), tmux no longer requires
      # reattach-to-user-namespace for clipboard and other integrations, so this wrapper
      # is generally safe to skip on these systems.
      set -gu default-command

      # Remove the global send-prefix binding added by Home Manager
      # unbind -n C-a

      # Bind 'a' in the prefix table to switch to the last window
      bind a last-window
    '';
  };

  home.packages = [ pkgs.tmux-scripts ];
}
