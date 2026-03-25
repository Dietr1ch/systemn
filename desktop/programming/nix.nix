{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/nix.nix
    systemPackages = with pkgs; [
      devenv

      # LSP
      nixd

      nix-diff

      nixfmt

      nixpkgs-review
    ]; # ..environment.systemPackages
  }; # ..environment
}
