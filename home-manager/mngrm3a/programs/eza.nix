{ pkgs, ... }:
let
  ezaOptions = "--group-directories-first --group --long --icons --git --git-ignore";
in
{
  programs.eza = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.zsh.shellAliases = {
    l1 = "command eza -1";
    lt = "eza --icons --git-ignore --tree";
    lsl = "eza ${ezaOptions}";
    lsd = "eza --only-dirs ${ezaOptions}";
    lsa = "eza --all --long --icons";
    lsc = "eza --created --long";
    lso = "eza --accessed --long";
    lse = "eza --extended --long";
    lst = "eza --tree --icons";
  };

  home.packages = [ pkgs.eza-scripts ];
}
