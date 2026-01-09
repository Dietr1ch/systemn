{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/nix.nix
    systemPackages = with pkgs; [
      # LSP
      nixd

      nix-diff

      # NOTE nixfmt still points to nixfmt-classic
      nixfmt-rfc-style

      nixpkgs-review
    ]; # ..environment.systemPackages
  }; # ..environment
}
