{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/config/toml.nix
    systemPackages = with pkgs; [
      taplo
    ]; # ..environment.systemPackages
  }; # ..environment
}
