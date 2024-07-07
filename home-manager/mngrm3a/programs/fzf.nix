{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.fzf = {
    enable = true;
    # * https://github.com/junegunn/fzf/wiki/Color-schemes#gruvbox-dark
    # * https://vitormv.github.io/fzf-themes/
    # * https://vitormv.github.io/fzf-themes#eyJib3JkZXJTdHlsZSI6InJvdW5kZWQiLCJib3JkZXJMYWJlbCI6IiIsImJvcmRlckxhYmVsUG9zaXRpb24iOjAsInByZXZpZXdCb3JkZXJTdHlsZSI6InJvdW5kZWQiLCJwYWRkaW5nIjoiMCIsIm1hcmdpbiI6IjAiLCJwcm9tcHQiOiI+ICIsIm1hcmtlciI6Ij4iLCJwb2ludGVyIjoi74GhIiwic2VwYXJhdG9yIjoi4pSAIiwic2Nyb2xsYmFyIjoi4pSCIiwibGF5b3V0IjoiZGVmYXVsdCIsImluZm8iOiJkZWZhdWx0IiwiY29sb3JzIjoiZmc6I2QwZDBkMCxmZys6I2QwZDBkMCxiZzojMTIxMjEyLGJnKzojMjYyNjI2LGhsOiM1Zjg3YWYsaGwrOiM1ZmQ3ZmYsaW5mbzojYWZhZjg3LG1hcmtlcjojODdmZjAwLHByb21wdDojZDcwMDVmLHNwaW5uZXI6I2FmNWZmZixwb2ludGVyOiNhZjVmZmYsaGVhZGVyOiM4N2FmYWYsYm9yZGVyOiMyNjI2MjYsbGFiZWw6I2FlYWVhZSxxdWVyeTojZDlkOWQ5In0=
    colors = {
      fg = "#ebdbb2";
      "fg+" = "#ebdbb2";
      bg = "#282828";
      "bg+" = "#3c3836";
      hl = "#fabd2f";
      "hl+" = "#fabd2f";
      info = "#83a598";
      prompt = "#bdae93";
      spinner = "#fabd2f";
      pointer = "#83a598";
      marker = "#fe8019";
      header = "#665c54";
    };
    defaultCommand = "fd --color=never --type f";
    # TODO: figure out how to use styling while having zsh widgets of proper size
    # defaultOptions = [
    #   "--border='rounded'"
    #   "--border-label=''"
    #   "--preview-window='border-rounded'"
    #   "--prompt='> '"
    #   "--marker='>'"
    #   "--pointer=''"
    #   "--separator='─'"
    #   "--scrollbar='│'"
    # ];
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
