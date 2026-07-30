{ ... }:
{
  programs.bat = {
    enable = true;
  };

  # TODO: do this via module config once home-manager supports it
  # see: https://github.com/sharkdp/bat#configuration-file
  home.sessionVariables = {
    BAT_THEME_LIGHT = "GitHub";
    BAT_THEME_DARK = "GitHub";
  };
}
