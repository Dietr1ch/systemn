{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # Quota
      quota

      # Inspect
      ncdu

      # Filesystems
      cryptsetup
      e2fsprogs   # fsck.ext4
      f2fs-tools  # fsck.f2fs
      ntfs3g      # NTFS
      exfat       # ExFAT
      gphoto2fs   # Cameras
      libgphoto2
      jmtpfs      # MTP
      gvfs
    ];
  };
}