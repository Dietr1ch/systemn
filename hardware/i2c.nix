{ pkgs, ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.i2c
    i2c = {
      enable = true;
    }; # ..hardware.i2c
  }; # ..hardware
}
