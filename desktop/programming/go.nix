{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/go.nix
    systemPackages = with pkgs; [
      go
      lisette

      go-tools
    ]; # ..environment.systemPackages
  }; # ..environment
}
