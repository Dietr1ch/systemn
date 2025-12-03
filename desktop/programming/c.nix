{ pkgs, ... }:

# https://nixos.wiki/wiki/C
{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/c.nix
    systemPackages = with pkgs; [
      gcc
      gdb
    ]; # ..environment.systemPackages
  }; # ..environment
}
