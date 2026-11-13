{ ... }:

{
  programs = {
    # NOTE: Deprecated
    # https://search.nixos.org/options?channel=unstable&query=programs.corectrl
    corectrl = {
      enable = true;
    }; # ..programs.corectrl
  }; # ..programs
}
