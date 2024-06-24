{
  config,
  lib,
  pkgs,
  ...
}:
{
  # integrations
  programs.fzf.enableZshIntegration = true;
  # ! IMPORTANT: aliases defined in zshrc collide eza's zsh integration
  programs.eza.enableZshIntegration = false;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    sessionVariables = {
      # * EDITOR is set in the nvim config
      # TODO: manage vscode via home manager
      VISUAL = "code";
    };

    shellAliases = {
      e = "$EDITOR";
      v = "$VISUAL";
      d = "$VISUAL --diff";
    };

    zplug = {
      enable = true;
      plugins = [
        # TODO: add plugins as flake input and use vanilla plugins
        # ? this might be problematic as fzf-tab requires a specific loading order
        # * see: https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#install
        { name = "Aloxaf/fzf-tab"; }
        # zsh-async is a dependency of pure
        { name = "mafredri/zsh-async"; }
        {
          name = "sindresorhus/pure";
          tags = [
            "use:pure.zsh"
            "as:theme"
          ];
        }
      ];
    };

    envExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';

    initExtra = builtins.readFile ./zshrc;
  };
}
