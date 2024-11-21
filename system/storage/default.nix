{ config, lib, pkgs, ... }:

{
  imports = [
    ./smartd.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      iotop

      quota
    ];
  };
}
