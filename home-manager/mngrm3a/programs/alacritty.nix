{
  config,
  lib,
  pkgs,
  ...
}:
let
  # * https://github.com/alacritty/alacritty-theme/tree/master/themes
  colorTheme = builtins.fromTOML (builtins.readFile "${pkgs.alacritty-theme}/gruvbox_dark.toml");
  fontFamily = "Inconsolata Nerd Font Mono";
in
{
  programs.alacritty = {
    # * https://alacritty.org/config-alacritty.html
    enable = true;
    settings = {
      window = {
        option_as_alt = "OnlyLeft";
        opacity = 1;
        startup_mode = "Fullscreen";
      };
      font = {
        size = 16;
        normal.family = fontFamily;
        bold.family = fontFamily;
        italic.family = fontFamily;
        bold_italic.family = fontFamily;
      };
      keyboard.bindings = [
        {
          chars = "\\u001BF";
          key = "Right";
          mods = "Alt";
        }
        {
          chars = "\\u001BB";
          key = "Left";
          mods = "Alt";
        }
      ];
    } // colorTheme;
  };
}
