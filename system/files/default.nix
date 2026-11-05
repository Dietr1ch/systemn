{ pkgs, ... }:

{
  imports = [
    ./compression.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # Quota
      quota

      # Inspect
      dua
    ]; # ..environment.systemPackages
  }; # ..environment
}
