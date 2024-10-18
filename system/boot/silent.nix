{ config, pkgs, lib, ... }:

{
  boot = {
    loader = {
      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      timeout = lib.mkDefault 0;
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
