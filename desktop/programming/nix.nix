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

      nix-prefetch
      nix-prefetch-git
      nix-prefetch-github
      nixpkgs-review
      nixpkgs-track
      nixpkgs-vet
    ]; # ..environment.systemPackages
  }; # ..environment
}
