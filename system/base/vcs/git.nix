{ lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.git
    git = {
      enable = lib.mkDefault true;

      # Populates /etc/gitconfig
      config = {
        init = {
          defaultBranch = lib.mkDefault "master";
        };
        core = {
          whitespace = lib.mkDefault "trailing-space,space-before-tab";
        };
        url = {
          # Codeberg: ssh://git@codeberg.org/{user}/{repo}.git
          "ssh://git@codeberg.org/" = {
            insteadOf = lib.mkDefault "cb:";
          };
          # GitHub: git@github.com:{user}/{repo}.git
          "git@github.com:" = {
            insteadOf = lib.mkDefault "gh:";
          };
          # GitHub Gist: git@github.com:{user}/{repo}.git
          "git@gist.github.com:" = {
            insteadOf = lib.mkDefault "gist:";
          };
        };
        pretty = {
          "oneliner" =
            "format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%<(12)%ar)%C(reset)  %s%C(dim white) - %an  %C(auto)%d%C(reset)'";
        };

        alias = {
          "exec" = lib.mkDefault "!exec ";

          "h" = lib.mkDefault "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
          "ll" = lib.mkDefault "log --graph --abbrev-commit --decorate --max-count 200";
          "lla" = lib.mkDefault "log --graph --abbrev-commit --decorate --max-count 200 --all";

          "publish" = lib.mkDefault "!sh -c 'git push -u origin $(git branch-name)'";
          "unpublish" = lib.mkDefault "!sh -c 'git push -u origin :$(git branch-name)'";

          "branch-name" = lib.mkDefault "rev-parse --abbrev-ref HEAD";
          "ls" = lib.mkDefault "!sh -c 'git ls-tree --name-only -r $(git branch-name)'";

          "clone-shallow" = lib.mkDefault "clone --single-branch --shallow-since '7 days'";
          "clone-commit" = lib.mkDefault "clone --single-branch --depth 1";
        };
      };
    };
  };
}
