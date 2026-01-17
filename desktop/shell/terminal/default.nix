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
  }; # ..users

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
    }; # ..programs.nix-index
  }; # ..programs

  documentation = {
    man = {
      enable = true;
    };
  }; # ..documentation

  environment = {
    systemPackages = with pkgs; [
      w3m-full
    ]; # ..environment.systemPackages
  }; # ..environment
}
