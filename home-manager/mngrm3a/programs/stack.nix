{ lib, ... }:
{
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
}
