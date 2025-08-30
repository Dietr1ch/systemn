{ pkgs, ... }:

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

    nix-index = {
      enable = true;
    };
  };

  documentation = {
    man = {
      enable = true;
    };
  };
}
