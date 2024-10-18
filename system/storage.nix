{ config, lib, pkgs, ... }:

{
  boot = {
    supportedFilesystems = [
      "ntfs"  # TODO Why would we need this at boot? UEFI uses FAT32
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      iotop

      quota
    ];
  };
}
