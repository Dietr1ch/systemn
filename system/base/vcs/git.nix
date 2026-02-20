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
      # man git-config(1)
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
    }; # ..programs.git
  }; # ..programs

  environment = {
    etc = {
      # /etc/gitattributes
      gitattributes = {
        text = ''
          # System-level attributes
          # Created from ~/Projects/systemn/system/base/vcs/git.nix

          # Mergiraf
          # https://mergiraf.org/usage.html#registration-as-a-git-merge-driver
          # mergiraf languages --gitattributes
          *.c merge=mergiraf
          *.c++ merge=mergiraf
          *.cc merge=mergiraf
          *.cpp merge=mergiraf
          *.cppm merge=mergiraf
          *.cs merge=mergiraf
          *.cxx merge=mergiraf
          *.dart merge=mergiraf
          *.dts merge=mergiraf
          *.go merge=mergiraf
          *.h merge=mergiraf
          *.h++ merge=mergiraf
          *.hcl merge=mergiraf
          *.hh merge=mergiraf
          *.hpp merge=mergiraf
          *.htm merge=mergiraf
          *.html merge=mergiraf
          *.hxx merge=mergiraf
          *.ini merge=mergiraf
          *.ixx merge=mergiraf
          *.java merge=mergiraf
          *.js merge=mergiraf
          *.json merge=mergiraf
          *.jsx merge=mergiraf
          *.kt merge=mergiraf
          *.lua merge=mergiraf
          *.md merge=mergiraf
          *.mjs merge=mergiraf
          *.mpp merge=mergiraf
          *.nix merge=mergiraf
          *.php merge=mergiraf
          *.phtml merge=mergiraf
          *.properties merge=mergiraf
          *.py merge=mergiraf
          *.rb merge=mergiraf
          *.rs merge=mergiraf
          *.sbt merge=mergiraf
          *.scala merge=mergiraf
          *.sol merge=mergiraf
          *.sv merge=mergiraf
          *.svh merge=mergiraf
          *.tcc merge=mergiraf
          *.tf merge=mergiraf
          *.tfvars merge=mergiraf
          *.toml merge=mergiraf
          *.ts merge=mergiraf
          *.tsx merge=mergiraf
          *.xhtml merge=mergiraf
          *.xml merge=mergiraf
          *.yaml merge=mergiraf
          *.yml merge=mergiraf
          * merge=mergiraf
        '';
        mode = "0444";
      };
    }; # ..environment.etc
    systemPackages = with pkgs; [
      mergiraf
    ]; # ..environment.systemPackages
  };
}
