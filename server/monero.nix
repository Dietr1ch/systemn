{ lib, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.monero
    monero = {
      enable = true;

      # https://docs.getmonero.org/interacting/monerod-reference/
      # https://docs.getmonero.org/interacting/monero-config-file/
      # /var/lib/monero/monerod.conf
      limits = {
        threads = lib.mkDefault 4;

        upload = lib.mkDefault 100; # 100kb/s
        download = lib.mkDefault 200; # 200kb/s
      };

      extraConfig = ''
        # https://docs.getmonero.org/interacting/monerod-reference/
        # Optional pruning
        prune-blockchain=1    # Pruning saves 2/3 of disk space w/o degrading functionality but contributes less to the network.
        sync-pruned-blocks=1  # Allow downloading pruned blocks instead of prunning them yourself.
      '';
    };
  };

  # https://docs.getmonero.org/interacting/monerod-reference/#p2p-network
  networking.firewall.allowedTCPPorts = [
    # - 18080 TCP for incoming connections (mainnet default)
    # - 18081 TCP for incoming RPC connections (can be configured to a different port with --rpc-bind-port)
    # - 53 UDP for DNS (optional)
    18080
  ];
}
