{
  config,
  lib,
  pkgs,
  specialArgs,
  ...
}@args:
let
  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  home.username = "mngrm3a";
  home.homeDirectory = if isDarwin then "/Users/mngrm3a" else "/home/mngrm3a";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
