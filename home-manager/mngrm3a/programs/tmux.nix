{
  config,
  lib,
  pkgs,
  ...
}:
let
  gruvbox-query-polarity = pkgs.writeShellScript "gruvbox-query-polarity.sh" ''
    if defaults read -g AppleInterfaceStyle &>/dev/null; then
      tmux set-option -g @tmux-gruvbox "dark256"
    else
      tmux set-option -g @tmux-gruvbox "light256"
    fi
  '';
  gruvbox-apply-polarity = pkgs.writeShellScript "gruvbox-apply-polarity.sh" ''
    ${gruvbox-query-polarity}
    ${pkgs.tmuxPlugins.gruvbox}/share/tmux-plugins/gruvbox/gruvbox-tpm.tmux
  '';
in
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
        extraConfig = "run-shell ${gruvbox-query-polarity}";
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

      # Bind 'C-g' in the prefix table to reapplu gruvbox with the current
      # system polarity
      bind-key C-g run-shell "${gruvbox-apply-polarity}"
    '';
  };

  home.packages = [ pkgs.tmux-scripts ];
}
