{ lib, ... }:

{
  boot = {
    loader = {
      # Shorten the bootloader selection timeout.
      timeout = lib.mkDefault 2;
    };

    # Enable "Silent Boot"
    initrd = {
      # Keep boot silent
      verbose = false;
    };

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
