{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/formatting.nix
    systemPackages = with pkgs; [
      treefmt
    ]; # ..environment.systemPackages
  }; # ..environment
}
