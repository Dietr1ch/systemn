{ pkgs, lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.git
    git = {
      enable = lib.mkDefault true;

      lfs = {
        enable = lib.mkDefault true;
      };

      # https://git-scm.com/docs/git-config
      # man:git-config(1)
      # Populates /etc/gitconfig
      # In sync with ~/Projects/nixland/core/vcs/git.nix
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
          "aliases" =
            lib.mkDefault "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /' | sort";

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

          # https://piechowski.io/post/git-commands-before-reading-code/
          # What Changes the Most
          "log-top-changed" =
            lib.mkDefault "!git log --format=format: --name-only --since='1 year ago' | sort | uniq --count | sort --numeric-sort --reverse | head -50";
          # Who Built This
          "log-top-contributors" = lib.mkDefault "!git shortlog --summary --numbered --no-merges";
          # Where Do Bugs Cluster
          "log-bug-nest" =
            lib.mkDefault "!git log --regexp-ignore-case --extended-regexp --grep='fix|bug|broken' --name-only --format='' | sort | uniq --count | sort --numeric-sort --reverse | head -50";
          # Is This Project Accelerating or Dying
          "log-commit-trend" =
            lib.mkDefault "!git log --format='%ad' --date=format:'%Y-%m' | sort | uniq --count";
          # How Often Is the Team Firefighting
          "log-incidents" =
            lib.mkDefault "!git log --oneline --regexp-ignore-case --extended-regexp --grep 'revert|hotfix|emergency|rollback' --since='1 year ago'";
        };
      };
    }; # ..programs.git
  }; # ..programs

  environment = {
    etc = {
      # /etc/gitignore
      gitignore = {
        text = ''
          # System-level ignores
          #
          # Pretty conservative since it affects everything
          #
          # Created from ~/Projects/systemn/system/base/vcs/git.nix

          # Unix
          ".*"
          "!.gitignore"

          # Temporary files
          "*~"
          "*.swp"

          # Backups
          "*.bak"
        '';
        mode = "0444";
      };
    }; # ..environment.etc
  };
}
