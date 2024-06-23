{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [ ];

  nix.package = pkgs.nix;
  home.packages = [ pkgs.nix ];
  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    username = "mngrm3a";
    homeDirectory = if isDarwin then "/Users/mngrm3a" else "/home/mngrm3a";
    language = {
      base = "en_US.UTF-8";
      measurement = "de_DE.UTF-8";
      monetary = "de_DE.UTF-8";
    };
  };
}
