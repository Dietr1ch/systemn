{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.fish;
  };

  programs = {
    bash = {
      completion = {
        enable = true;
      };
    };
    fish = {
      enable = true;
    };

    command-not-found = {
      enable = true;
    };
  };

  documentation = {
    man = {
      enable = true;
    };
  };
}
