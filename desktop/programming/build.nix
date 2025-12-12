{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/build.nix
    systemPackages = with pkgs; [
      gnumake
      just

      binutils
      lld
      mold
    ]; # ..environment.systemPackages
  }; # ..environment
}
