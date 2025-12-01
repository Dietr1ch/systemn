{ pkgs, ... }:

# https://nixos.wiki/wiki/Wine
{
  hardware.graphics.enable32Bit = true;

  environment = {
    systemPackages = with pkgs; [
      lutris

      winetricks
      wineWowPackages.waylandFull
    ];
  };

}
