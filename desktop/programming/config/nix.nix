{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/config/nix.nix
    systemPackages = with pkgs; [
      # Formatting
      nixpkgs-fmt

      # LSP
      vscode-langservers-extracted
    ]; # ..environment.systemPackages
  }; # ..environment
}
