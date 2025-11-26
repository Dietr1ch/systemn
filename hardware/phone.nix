{ ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.adb
    adb = {
      enable = true;
    }; # ..programs.adb

    # https://search.nixos.org/options?channel=unstable&query=programs.kdeconnect
    kdeconnect = {
      enable = true;
    }; # ..programs.kdeconnect
  }; # ..programs
}
