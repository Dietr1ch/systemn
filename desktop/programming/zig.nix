{ pkgs, ... }:

{
  environment = {
    # Packages in sync with ~/Projects/nixland/programming/zig.nix
    systemPackages = with pkgs; [
      zig

      zls
      zig-zlint
    ]; # ..environment.systemPackages
  }; # ..environment
}
