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
      # NOTE: dependency of pure
      {
        name = "zsh-async";
        src = zsh-async;
        file = "async.zsh";
      }
      {
        name = "pure";
        src = pure-prompt;
        file = "share/zsh/site-functions/prompt_pure_setup";
      }
      {
        name = "fzf-tab";
        src = zsh-fzf-tab;
      }
      {
        name = "simple-zsh-nix-shell";
        src = simple-zsh-nix-shell;
      }
    ];

    envExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';

    initExtra = ''
      source <(${pkgs.zsh-toolbox}/bin/zsh-toolbox-exe --completions)
      ${builtins.readFile ./zshrc}
    '';
  };

  # NOTE: this is needed to make simple-zsh-nix-shell work
  # https://github.com/goolord/simple-zsh-nix-shell?tab=readme-ov-file#install 
  home.file.".bashrc".text = ''
    if [ ! -z ''${SIMPLE_ZSH_NIX_SHELL_BASH+x} ] ;
      then source $SIMPLE_ZSH_NIX_SHELL_BASH
    fi
  '';

  # zsh toolbox
  home.file.".local/bin/tx".source = "${pkgs.zsh-toolbox}/bin/zsh-toolbox-exe";
}
