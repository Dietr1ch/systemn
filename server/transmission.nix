{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.transmission
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/torrent/transmission.nix
    transmission = {
      enable = true;

      package = pkgs.transmission_4-qt6; # Can be paired with standalone in ://desktop/shell/graphical/tools.nix

      openPeerPorts = true;
      # https://search.nixos.org/options?channel=unstable&show=services.transmission.performanceNetParameters
      performanceNetParameters = true;
      settings = {
        # https://github.com/transmission/transmission/wiki/Editing-Configuration-Files
        peer-port-random-on-start = true;
        incomplete-dir-enabled = true;
        watch-dir-enabled = true;
      };
    };
  };
}
