{ config, lib, pkgs, ... }:

{
  programs = {
    mtr = {
      enable = true;
    };
    wireshark = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      nmap
    ];
  };
}
