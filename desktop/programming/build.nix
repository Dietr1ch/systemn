{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/build.nix
    systemPackages = with pkgs; [
      pkg-config
      gnumake
      just
      just-lsp

      binutils
      lld
      mold
    ]; # ..environment.systemPackages
  }; # ..environment
}
