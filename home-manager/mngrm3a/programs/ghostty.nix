{ lib, ... }:
let
  toINI =
    attrs:
    builtins.concatStringsSep "\n" (
      map (k: lib.generators.mkKeyValueDefault { } "=" k (attrs.${k})) (builtins.attrNames attrs)
    );
in
{
  # TODO: manage config via home-manager module
  # this is only necessary because ghostty is marked as broken on macos
  # NOTE: remove toINI as its only used here
  home.file.".config/ghostty/config".text = toINI {
    theme = "light:Github Light Default,dark:Github Dark Dimmed";
    font-size = 17;
    fullscreen = true;
    font-family = "Inconsolata Nerd Font Mono";
  };
}
