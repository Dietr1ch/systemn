{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./colours.nix
  ];

  users = {
    defaultUserShell = pkgs.fish;
  };

  programs = {
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
