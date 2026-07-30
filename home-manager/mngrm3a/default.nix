{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{

  imports = [
    ./programs/alacritty.nix
    ./programs/ghostty.nix
    ./programs/zsh.nix
    ./programs/tmux.nix
    # ./programs/zellij.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/eza.nix
    ./programs/nvim.nix
    ./programs/bat.nix
    ./programs/bun.nix
    ./programs/stack.nix
  ];

  home = {
    stateVersion = "26.05";
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

  home.file."Library/LaunchAgents/com.local.KeyRemapping.plist" = {
    # NOTE:
    # * CapsLock -> LeftControl
    # * RightOption -> LeftControl
    enable = isDarwin;
    source = ./macos/com.local.KeyRemapping.plist;
  };
}
