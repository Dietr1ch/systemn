{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.transmission
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/torrent/transmission.nix
    transmission = {
      enable = true;

      package = pkgs.transmission_4;

      openPeerPorts = true;
      settings = {
        # https://github.com/transmission/transmission/wiki/Editing-Configuration-Files
        peer-port-random-on-start = true;
        incomplete-dir-enabled = true;
        watch-dir-enabled = true;
      };
    };
  };
}
