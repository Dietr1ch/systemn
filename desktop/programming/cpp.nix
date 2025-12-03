{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/cpp.nix
    systemPackages = with pkgs; [
      gcc
      gdb
    ]; # ..environment.systemPackages
  }; # ..environment
}
