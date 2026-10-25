{ pkgs, ... }:

{
  programs = {
    wireshark = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      aria2
      dogedns
      ethtool
      rsync
      rustscan
      wget
      wol
      xh
    ];
  };
}
