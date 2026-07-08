{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/asp.nix
    systemPackages = with pkgs; [
      clingo
      clingcon
    ]; # ..environment.systemPackages
  }; # ..environment
}
