{ lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.git
    git = {
      enable = lib.mkDefault true;

      # https://git-scm.com/docs/git-config
      # Populates /etc/gitconfig
      config = {
        init = {
          defaultBranch = lib.mkDefault "master";
        };
        core = {
          whitespace = lib.mkDefault "trailing-space,space-before-tab";
        };
        url = {
          # Codeberg
          "https://codeberg.org/" = {
            insteadOf = lib.mkDefault "cb:";
          };
          "ssh://git@codeberg.org/" = {
            pushInsteadOf = lib.mkDefault "cb:";
          };

          # GitHub
          "https://github.com/" = {
            insteadOf = lib.mkDefault "gh:";
          };
          "git@github.com:" = {
            pushInsteadOf = lib.mkDefault "gh:";
          };
          "https://gist.github.com/" = {
            insteadOf = lib.mkDefault "gist:";
          };
          "git@gist.github.com:" = {
            pushInsteadOf = lib.mkDefault "gist:";
          };

          # GitLab
          "https://gitlab.com/" = {
            insteadOf = lib.mkDefault "gl:";
          };
          "git@gitlab.com:" = {
            pushInsteadOf = lib.mkDefault "gl:";
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
