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
    plugins = with pkgs.vimPlugins; [
      # extra dependency
      plenary-nvim

      # mngrm3a.pretty
      gruvbox-nvim
      noice-nvim
      lualine-nvim
      nvim-web-devicons
      # lspkind-nvim

      # mngrm3a.comments
      todo-comments-nvim

      # mngrm3a.telescope
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim

      # mngrm3a.treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects

      # mngrm3a.lsp
      nvim-lspconfig

      # mngrm3a.vcs
      gitsigns-nvim
      diffview-nvim
      neogit

      # mngrm3a.completion
      blink-cmp

      # utils
      which-key-nvim
      undotree
      oil-nvim
    ];
  };

  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style

    lua-language-server

    nodePackages.bash-language-server
    shellcheck
    shfmt
  ];

  programs.zsh.shellAliases = {
    e = "$EDITOR";
    d = "$EDITOR -d";
  };
}
