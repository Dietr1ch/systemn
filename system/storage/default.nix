{ config, lib, pkgs, ... }:

{
  imports = [
    ./fstrim.nix
    ./smartd.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      iotop

      quota
    ];
  };
}
