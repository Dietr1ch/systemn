{ lib, ... }:

# https://wiki.nixos.org/wiki/Swap
# https://www.kernel.org/doc/Documentation/blockdev/zram.txt
{
  boot = {
    kernel = {
      sysctl = {
        # https://docs.kernel.org/admin-guide/sysctl/vm.html#swappiness
        "vm.swappiness" = lib.mkDefault 15; # Only swap under real pressure
      }; # ..boot.kernel.sysctl
    }; # ..boot.kernel
  }; # ..boot

  # https://search.nixos.org/options?channel=unstable&query=zramSwap
  zramSwap = {
    enable = true;

    # priority = 5;
    # algorithm = "zstd";
    # memoryMax = null;
    # swapDevices = 1;
    # memoryPercent = 50;
    # writebackDevice = null;
  }; # ..zramSwap
}
