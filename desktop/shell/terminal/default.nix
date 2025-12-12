{ pkgs, ... }:

{
  imports = [
    ./colours.nix
    ./fonts.nix
    # ./pay-respects.nix
    ./prompt.nix
  ];

  users = {
    defaultUserShell = pkgs.fish;
  };

  programs = {
    fish = {
      enable = true;
    };

    # https://search.nixos.org/options?channel=unstable&query=programs.nix-index
    nix-index = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };

  documentation = {
    man = {
      enable = true;
    };
  };
}
