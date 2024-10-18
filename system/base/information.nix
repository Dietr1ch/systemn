{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lshw
      aha
      clinfo
      pciutils
      usbutils

      unixtools.top
      lsof
      powertop

      # ../storage.nix
    ];
  };
}
