{ pkgs, lib, ... }:

{
  imports = [
    ./nintendo.nix
    ./xbox.nix
  ];

  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.steam-hardware
    steam-hardware = {
      enable = true;
    };

    # https://search.nixos.org/options?channel=unstable&query=hardware.bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;

      # https://github.com/bluez/bluez/blob/master/src/main.conf
      settings = {
        General = {
          # Shows battery charge of connected devices on supported
          # Bluetooth adapters. Defaults to 'false'.
          Experimental = lib.mkDefault true;
          # When enabled other devices can connect faster to us, however
          # the tradeoff is increased power consumption. Defaults to
          # 'false'.
          FastConnectable = lib.mkDefault true;
        };
        Policy = {
          # Enable all controllers when they are found. This includes
          # adapters present on start as well as adapters that are plugged
          # in later on. Defaults to 'true'.
          AutoEnable = lib.mkDefault true;
        };
      };
    }; # ..hardware.bluetooth
  }; # ..hardware

  services = {
    udev = {
      packages = with pkgs; [
        game-devices-udev-rules
      ];
    }; # ..services.udev
  }; # ..services

}
