{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "mngrm3a";
        email = "9266859+mngrm3a@users.noreply.github.com";
      };
      init.defaultBranch = "master";
      core.editor = "nvim";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      credential.helper = "osxkeychain";
      aliases = {
        graph = "log --oneline --graph --decorate --all";
      };
    };
  };

  programs.zsh.shellAliases = {
    gd = "git diff";
    gp = "git pull";
    gP = "git push";
    gPU = "git branch --show-current | xargs git push --set-upstream origin";
    gbs = "git switch";
    gbS = "git switch --create";
    gbl = "git branch";
    gbL = "git branch --remotes";
    gbd = "git branch -d";
    gbD = "git branch -D";
    gbm = "git branch -m";
    gbM = "git branch -M";
    gbR = "git reset --hard";
  };

  home.packages = [ pkgs.git-scripts ];
}
