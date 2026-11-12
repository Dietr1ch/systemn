{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Swap
# https://www.kernel.org/doc/Documentation/blockdev/zram.txt
{
  boot = {
    kernel = {
      sysctl = {
        # https://docs.kernel.org/admin-guide/sysctl/vm.html#swappiness
        # NOTE: This measures how cheap is it to swap vs dropping cached ("free") memory.
        # A value of 100 says that they have equal cost.
        "vm.swappiness" = lib.mkDefault 120; # Make swapping to zram sligtly cheaper than freeing cached memory.
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

  assertions = [
    {
      assertion = config.swapDevices == [ ];
      message = "SystemN: zramswap module: A disk-based swap device is defined. Remove it to avoid slow disk swapping.";
    }
  ]; # ..assertions
}
