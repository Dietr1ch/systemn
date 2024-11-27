{ config, lib, pkgs, ... }:

{
  programs = {
    mtr = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      nmap
    ];
  };
}
