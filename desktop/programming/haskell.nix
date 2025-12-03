{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/haskell.nix
    systemPackages = with pkgs; [
      ghc
    ];
  }; # ..environment
}
