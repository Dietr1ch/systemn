{ config, lib, pkgs, ... }:

{
  imports = [
    ./fstrim.nix
    ./smartd.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # Monitoring
      iotop

      # Quota
      quota

      # Inspect
      ncdu

      # Manage
      gptfdisk
      smartmontools
      nvme-cli

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
