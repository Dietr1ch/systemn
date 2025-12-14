{ pkgs, ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.xpadneo
    xpadneo.enable = true;

    # https://search.nixos.org/options?channel=unstable&query=hardware.xone
    xone.enable = true; # support for the xbox controller USB dongle
  }; # ..hardware

  environment = {
    systemPackages = with pkgs; [
      xow_dongle-firmware
    ]; # ..environment.systemPackages
  }; # ..environment
}
