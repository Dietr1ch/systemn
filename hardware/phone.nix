{ ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.adb
    adb = {
      enable = true;
    };  # ..programs.adb
  };  # ..programs
}
