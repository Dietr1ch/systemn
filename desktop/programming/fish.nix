{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/fish.nix
    systemPackages = with pkgs; [
      fish-lsp
    ]; # ..environment.systemPackages
  }; # ..environment
}
