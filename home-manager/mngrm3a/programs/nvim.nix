{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = lib.mkAfter ''
      vim.opt.rtp:prepend("~/Projects/mngrm3a.nvim")
      require("config.lazy")
    '';
  };

  home.packages = with pkgs; [
    nil
    nixfmt

    lua-language-server

    bash-language-server
    shellcheck
    shfmt
  ];

  programs.zsh.shellAliases = {
    e = "$EDITOR";
    d = "$EDITOR -d";
  };
}
