{ ... }:

# https://wiki.nixos.org/wiki/Swap
{
  boot = {
    # https://search.nixos.org/options?channel=unstable&query=boot.zswap
    zswap = {
      enable = true;

      # zpool = "zmalloc";
      # compressor = "zstd";
      # maxPoolPercent = 25;
      # shrinkerEnabled = true;
      # acceptThresholdPercent = 90;
    }; # ..boot.zswap
  }; # ..boot
}
