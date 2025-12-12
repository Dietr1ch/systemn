{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/debugging.nix
    systemPackages = with pkgs; [
      gdb
    ]; # ..environment.systemPackages
  }; # ..environment
}
