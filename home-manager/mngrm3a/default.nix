{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
  toINI =
    attrs:
    builtins.concatStringsSep "\n" (
      map (k: lib.generators.mkKeyValueDefault { } "=" k (attrs.${k})) (builtins.attrNames attrs)
    );
in
{
  imports = [
    ./programs/alacritty.nix
    ./programs/zsh.nix
    ./programs/tmux.nix
    ./programs/zellij.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/eza.nix
  ];

  home = {
    stateVersion = "25.05";
    username = "mngrm3a";
    homeDirectory = if isDarwin then "/Users/mngrm3a" else "/home/mngrm3a";
    language = {
      base = "en_US.UTF-8";
      measurement = "de_DE.UTF-8";
      monetary = "de_DE.UTF-8";
    };
  };

  nix.package = pkgs.nix;
  home.packages = with pkgs; [
    nix
    nix-scripts
    cheat-more
  ];
  programs.home-manager.enable = true;

  programs.ripgrep.enable = true;
  programs.zoxide.enable = true;

  programs.bat = {
    enable = true;
  };
  # TODO: do this via module config once home-manager supports it
  home.sessionVariables = {
    BAT_THEME_LIGHT = "gruvbox-light";
    BAT_THEME_DARK = "gruvbox-dark";
  };

  home.file."Library/LaunchAgents/com.local.KeyRemapping.plist" = {
    # NOTE:
    # * CapsLock -> LeftControl
    # * RightOption -> LeftControl
    enable = isDarwin;
    source = ./macos/com.local.KeyRemapping.plist;
  };

  home.file.".stack/config.yaml".text = lib.generators.toYAML { } {
    templates = {
      params = {
        author-name = "mngrm3a";
        author-email = "9266859+mngrm3a@users.noreply.github.com";
        copyright = "2024 mngrm3a";
        github-username = "mngrm3a";
      };
    };
  };

  # TODO: manage config via home-manager module
  # this is only necessary because ghostty is marked as broken on macos
  # NOTE: remove toINI as its only used here
  home.file.".config/ghostty/config".text = toINI {
    theme = "light:Gruvbox Light,dark:Gruvbox Dark";
    font-size = 17;
    fullscreen = true;
    font-family = "Inconsolata Nerd Font Mono";
  };
}
