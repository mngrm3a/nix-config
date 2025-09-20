{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --color=never --type f";
    fileWidgetCommand = "fd --color=never --type f";
    fileWidgetOptions = [
      "--preview 'bat -n --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"

    ];
    historyWidgetOptions = [
      "--preview 'echo {}' --preview-window up:3:hidden:wrap"
      "--bind 'ctrl-/:toggle-preview'"
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
      "--color header:italic"
      "--header 'Press CTRL-Y to copy command into clipboard'"
    ];
    changeDirWidgetCommand = "fd --color=never --type d";
    changeDirWidgetOptions = [ "--preview 'eza --color=always --tree --icons --git-ignore {}'" ];
  };

  home.packages = with pkgs; [ fd ];
}
