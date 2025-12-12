{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/build.nix
    systemPackages = with pkgs; [
      gnumake
      just

      mold
    ]; # ..environment.systemPackages
  }; # ..environment
}
