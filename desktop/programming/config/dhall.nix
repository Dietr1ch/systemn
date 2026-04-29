{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/config/dhall.nix
    systemPackages = with pkgs; [
      dhall
      dhall-lsp-server
      dhall-json
    ]; # ..environment.systemPackages
  }; # ..environment
}
