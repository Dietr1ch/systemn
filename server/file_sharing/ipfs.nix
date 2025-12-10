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
    };
  };
}
