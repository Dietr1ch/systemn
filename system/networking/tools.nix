{ config, lib, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      wol
      wget
      sshfs-fuse
      nmap
    ];
  };
}
