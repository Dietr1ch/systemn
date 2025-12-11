{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      transmission_4-qt6 # For pairing with ://server/transmission.nix

      gpu-viewer

      gparted
      meld
    ];
  };
}
