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
    extraConfig = builtins.readFile ./tmux.conf;
    terminal = "screen-256color";
  };
}
