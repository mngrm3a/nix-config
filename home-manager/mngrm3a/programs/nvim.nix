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
      tokyonight-nvim
      lualine-nvim
      nvim-web-devicons
      noice-nvim
      lspkind-nvim

      # mngrm3a.comments
      todo-comments-nvim

      # mngrm3a.telescope
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      # mngrm3a.treesitter
      nvim-treesitter.withAllGrammars

      # mngrm3a.lsp
      nvim-lspconfig

      # mngrm3a.terminal
      iron-nvim

      # mngrm3a.vcs
      gitsigns-nvim
      diffview-nvim
      neogit

      # mngrm3a.completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-cmdline
      cmp-path
      cmp-buffer
      cmp_luasnip
      cmp-nvim-lsp-signature-help
      cmp-nvim-lsp-document-symbol
      luasnip

      # utils
      which-key-nvim
      undotree
      oil-nvim

      # TODO: import as flake when config is stable
      # config plugin
      # mngrm3a-nvim
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
