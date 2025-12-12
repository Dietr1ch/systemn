{ ... }:

# https://nixos.wiki/wiki/IPFS
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.kubo
    kubo = {
      enable = true;

      autoMount = true;
      startWhenNeeded = true;
      enableGC = true;

      # NOTE: This risks bans in cloud/datacenters.
      # localDiscovery = lib.mkDefault true;

      # https://github.com/ipfs/kubo/blob/master/docs/config.md
      #
      # Sets $IPFS_PATH/config
      settings = {
        Addresses = {
          API = [
            "/ip4/127.0.0.1/tcp/5001"
          ];
        };
      };
    };
  };
}
