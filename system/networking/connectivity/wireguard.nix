{ config, pkgs, ... }:

# https://wiki.nixos.org/wiki/WireGuard
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      wireguard
    ];
  };

  networking = {
    # https://search.nixos.org/options?channel=unstable&query=networking.wireguard
    wireguard = {
      enable = true;
    };
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.wgautomesh
    wgautomesh = {
      enable = true;

      settings = {
        enablePersistence = true;
        enableGossipEncryption = true;
        lan_discovery = true;

        # ../../secrets.nix
        # TODO: Add notes on how to create the files
        # gossipSecretFile = /var/secrets/wgam-gossip;
        # gossipSecretFile = "??";
        # peers = {
        #   "mate" = {
        #     pubkey = "??";
        #     # Bootstrap
        #     # address = "";
        #     # endpoint = "";
        #   };
        # };
      };
    };

    prometheus = {
      exporters = {
        # https://search.nixos.org/options?channel=unstable&query=services.prometheus.exporters.wireguard
        wireguard = {
          enable = true;

          latestHandshakeDelay = true;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wireguard-tools
      wireguard-vanity-keygen
    ];
  };
}
