{ pkgs, ... }:
let
  # see: https://github.com/alacritty/alacritty-theme/tree/master/themes
  colorTheme = "github_light";
  # colorTheme = "gruvbox_dark";
  font = {
    family = "Inconsolata Nerd Font Mono";
    style = "Regular";
  };
in
{
  programs.alacritty = {
    # see: https://alacritty.org/config-alacritty.html
    enable = true;
    settings = {
      window = {
        option_as_alt = "OnlyLeft";
        opacity = 1;
        startup_mode = "Fullscreen";
      };
      # see:  https://dev.to/eparreno/smoother-fonts-for-alacritty-on-macos-3b4f
      font = {
        size = 15;
        offset = {
          x = 0;
          y = 0;
        };
        normal = font;
        bold = font;
        italic = font;
        bold_italic = font;
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
        {
          key = "Up";
          mods = "Command";
          action = "IncreaseFontSize";
        }
        {
          key = "Down";
          mods = "Command";
          action = "DecreaseFontSize";
        }
      ];
    }
    // builtins.fromTOML (
      builtins.readFile "${pkgs.alacritty-theme}/share/alacritty-theme/${colorTheme}.toml"
    );
  };
}
