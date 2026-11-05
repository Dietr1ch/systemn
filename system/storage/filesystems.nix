{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # File systems
      cryptsetup
      e2fsprogs # fsck.ext4
      exfat
      f2fs-tools
      ntfs3g

      # VFS
      gvfs

      gphoto2fs # Cameras
      libgphoto2
    ]; # ..environment.systemPackages
  }; # ..environment
}
