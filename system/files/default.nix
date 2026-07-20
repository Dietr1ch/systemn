{ pkgs, ... }:

{
  imports = [
    ./compression.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # Quota
      quota

      # Inspect
      dua

      # Filesystems
      cryptsetup
      e2fsprogs # fsck.ext4
      exfat
      f2fs-tools
      ntfs3g

      # VFS
      gvfs

      gphoto2fs # Cameras
      libgphoto2
    ];
  };
}
