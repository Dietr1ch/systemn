{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      kdePackages.kasts # TODO: Find a new home for kasts

      transmission_4-qt6 # For pairing with ://server/transmission.nix

      gpu-viewer

      gparted
      meld
    ];
  };
}
