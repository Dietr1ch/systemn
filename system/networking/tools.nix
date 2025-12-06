{ pkgs, ... }:

{
  programs = {
    wireshark = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      ethtool
      rsync
      rustscan
      wget
      wol
    ];
  };
}
