{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "mngrm3a";
    userEmail = "9266859+mngrm3a@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "master";
      core.editor = "nvim";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
    };
    aliases = {
      graph = "log --oneline --graph --decorate --all";
    };
    difftastic = {
      enable = true;
      background = "dark";
      display = "side-by-side-show-both";
    };
  };
}
