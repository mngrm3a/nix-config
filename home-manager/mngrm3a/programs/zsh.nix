{
  config,
  lib,
  pkgs,
  ...
}:
{
  # integrations
  programs.fzf.enableZshIntegration = true;
  # WARN: aliases defined in zshrc collide with eza zsh integration
  programs.eza.enableZshIntegration = false;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    sessionVariables = {
      # NOTE: EDITOR is set in the nvim config
      # TODO: manage vscode via home manager
      VISUAL = "code";
    };

    shellAliases = {
      e = "$EDITOR";
      v = "$VISUAL";
      d = "$EDITOR -d";
    };

    plugins = with pkgs; [
      {
        name = "zsh-async";
        src = zsh-async;
        file = "async.zsh";
      }
      {
        name = "fzf-tab";
        src = zsh-fzf-tab;
      }
      {
        name = "pure";
        src = zsh-pure;
        file = "pure.zsh";
      }
    ];

    envExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';

    initExtra = builtins.readFile ./zshrc;
  };
}
