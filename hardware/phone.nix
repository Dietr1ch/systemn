{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.kdeconnect
    kdeconnect = {
      enable = true;
    }; # ..programs.kdeconnect
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      android-tools
    ];
  }; # ..environment
}
