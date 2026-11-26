{ pkgs, ... }:

{
  environment = {
    # In sync with ~/Projects/nixland/core/vcs/clients/gitlab.nix
    systemPackages = with pkgs; [
      gitlab-ci-linter
      gitlab-ci-local
      gitlab-ci-validate
    ];
  };
}
