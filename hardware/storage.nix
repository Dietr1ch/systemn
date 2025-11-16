{ lib, ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.block
    block = {
      scheduler = {
        # Available schedulers depend on the kernel configuration but modern
        # Linux systems typically support:
        #
        # * none :: No‐operation scheduler with no re‐ordering of requests.
        #           Suitable for devices with fast random I/O such as NVMe SSDs.
        #
        # * mq-deadline :: Simple latency‐oriented general‐purpose scheduler.
        #
        # * kyber :: Simple latency‐oriented scheduler for fast multi‐queue
        #            devices like NVMe SSDs.
        #
        # * bfq :: Complex fairness‐oriented scheduler. Higher processing
        #          overhead, but good interactive response, especially with
        #          slower devices.
        #
        # Schedulers assigned through this option take precedence over
        # hardware.block.defaultScheduler and
        # hardware.block.defaultSchedulerRotational but may be overridden by
        # other udev rules.
        "mmcblk[0-9]*" = lib.mkDefault "bfq";
        "nvme[0-9]*" = lib.mkDefault "kyber";
      };
      defaultSchedulerRotational = "bfq";
    };
  };
}
