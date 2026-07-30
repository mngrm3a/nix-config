{ lib, pkgs, ... }:
{
  # NOTE: Hint from the homemanger news section
  #
  # 2026-04-17 15:00:13 [read]
  #
  # The module `programs.neovim` now writes to
  # {file}`$XDG_CONFIG_HOME/nvim/init.lua` by default.
  #
  # If you want to manage {file}`$XDG_CONFIG_HOME/nvim/init.lua` yourself, you
  # can set {option}`programs.neovim.sideloadInitLua` to `true` to load the
  # content of {option}`programs.neovim.initLua` through neovim wrapper
  # arguments instead.

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = lib.mkAfter ''
      vim.opt.rtp:prepend("~/Projects/mngrm3a.nvim")
      require("config.lazy")
    '';
  };

  home.packages = with pkgs; [
    prettier

    nil
    nixfmt

    shellcheck

    bash-language-server
    shfmt

    markdown-oxide
    vscode-json-languageserver
    yaml-language-server
  ];

  programs.zsh.shellAliases = {
    e = "$EDITOR";
    d = "$EDITOR -d";
  };
}
