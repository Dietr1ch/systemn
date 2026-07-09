{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      apksigner
      apktool
    ]; # ..environment.systemPackages
  }; # ..environment
}
