{ config, lib, pkgs, ... }:

{
  imports = [
    ./connectivity  # connectivity/default.nix

    ./information.nix
    ./tools.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=networking
  networking = {
    networkmanager = {
      enable = true;
    };

    dhcpcd = {
      enable = true;

      wait = "background";

      extraConfig = ''
        noarp  # Avoid checking if the IP is taken
      '';
    };

    # Firewall
    # --------
    # https://nixos.wiki/wiki/Firewall
    firewall = {
      enable = true;

      allowPing = true;
    };

    # Use nftables as the Firewall
    nftables = {
      enable = true;
    };
  };
}
