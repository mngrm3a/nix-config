{ pkgs, ... }:
{
  # integrations
  programs.fzf.enableZshIntegration = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

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
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "simple-zsh-nix-shell";
        src = simple-zsh-nix-shell;
      }
    ];

    localVariables = {
      SHELL = "${pkgs.zsh}/bin/zsh";
    };

    envExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';

    profileExtra = ''
      # Add Visual Studio Code (code)
      path+=('/Applications/Visual Studio Code.app/Contents/Resources/app/bin')
      path+=("$HOME/.miniforge/condabin")
      export PATH
    '';

    initContent = ''
      # case-insensitive matching only if there are no case-sensitive matches
      # see https://superuser.com/a/1092328
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}'
    '';
  };

  # NOTE: this is needed to make simple-zsh-nix-shell work
  # https://github.com/goolord/simple-zsh-nix-shell?tab=readme-ov-file#install
  home.file.".bashrc".text = ''
    if [ ! -z ''${SIMPLE_ZSH_NIX_SHELL_BASH+x} ] ;
      then source $SIMPLE_ZSH_NIX_SHELL_BASH
    fi
  '';
}
