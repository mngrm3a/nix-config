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
    terminal = "tmux-256color";
    extraConfig = ''
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      setw -g mouse on
      setw -g monitor-activity on
      set -ag terminal-overrides ",$TERM:Tc"
    '';
  };

  home.packages = [ pkgs.tmux-scripts ];
}
