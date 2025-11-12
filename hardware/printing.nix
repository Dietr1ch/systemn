{ pkgs, ... }:

# https://nixos.wiki/wiki/Printing
{
  services = {
    printing = {
      enable = true;

      # https://nixos.wiki/wiki/Printing#Drivers
      drivers = with pkgs; [
        gutenprintBin
      ];
    };
  };
}
