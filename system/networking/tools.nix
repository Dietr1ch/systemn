{ pkgs, ... }:

{
  programs = {
    wireshark = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      dogedns
      ethtool
      rsync
      rustscan
      wget
      wol
    ];
  };
}
