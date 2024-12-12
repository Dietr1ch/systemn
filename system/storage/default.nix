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

      # Manage
      gptfdisk
      smartmontools
      nvme-cli
    ];
  };
}
