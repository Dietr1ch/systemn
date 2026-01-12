{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/grammars.nix
    systemPackages = with pkgs; [
      tree-sitter
    ]; # ..environment.systemPackages
  }; # ..environment
}
