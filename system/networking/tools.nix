{ pkgs, ... }:

{
  programs = {
    wireshark = {
      enable = true;
    };
  };
  environment = {
    systemPackages = with pkgs; [
      wget
      # TODO: Add `wol`
      # wol
    ];
  };
}
