{ config, lib, pkgs, ... }:

{
  imports = [
    ./colours.nix
    ./fonts.nix
    # ./pay-respects.nix
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
