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
    clock24 = true;
    keyMode = "vi";
    shortcut = "a";
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = gruvbox;
        extraConfig = "set -g @tmux-gruvbox 'dark' # or 'light'";
      }
      { plugin = tmux-fzf; }
    ];
    extraConfig = ''
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      setw -g mouse on
      setw -g monitor-activity on
      set -g status-right "#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] #(gitmux \"#{pane_current_path}\")#[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]  %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h"
    '';
    # handled by sensible
    # https://nix-community.github.io/home-manager/options.html#opt-programs.tmux.sensibleOnTop
    # https://github.com/tmux-plugins/tmux-sensible#options
    terminal = "screen-256color";
  };

  home.packages = [ pkgs.gitmux ];
}
