{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --color=never --type f";
    fileWidget = {
      command = "fd --color=never --type f";
      options = [
        "--preview 'bat -n --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(down|hidden|)'"

      ];
    };
    historyWidget.options = [
      "--preview 'echo {}' --preview-window up:3:hidden:wrap"
      "--bind 'ctrl-/:toggle-preview'"
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
      "--color header:italic"
      "--header 'Press CTRL-Y to copy command into clipboard'"
    ];
    changeDirWidget = {
      command = "fd --color=never --type d";
      options = [ "--preview 'eza --color=always --tree --icons --git-ignore {}'" ];
    };
  };
  home.packages = with pkgs; [ fd ];
}
