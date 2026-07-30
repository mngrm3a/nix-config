{
  config,
  lib,
  pkgs,
  ...
}:
let
  settings = {
    install = {
      cache = {
        dir = "${config.home.homeDirectory}/.cache/bun/install/cache";
      };
    };
  };
in
{
  programs.bun = {
    settings = settings;
  };

  home.file.".bunfig.toml" = lib.mkIf (!config.programs.bun.enable) {
    source = (pkgs.formats.toml { }).generate "bunfig.toml" settings;
  };
}
