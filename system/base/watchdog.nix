{ pkgs, ... }:

{
  systemd = {
    # https://search.nixos.org/options?channel=unstable&query=systemd.watchdog
    # https://www.freedesktop.org/software/systemd/man/latest/systemd-system.conf.html#Hardware%20Watchdog
    watchdog = {
      # The amount of time which can elapse before a watchdog hardware device
      # will automatically reboot the system.
      runtimeTime = "20s";

      # The amount of time which can elapse after a reboot has been triggered
      # before a watchdog hardware device will automatically reboot the system.
      # If left null, systemd will use its default of 10 minutes; see
      # systemd-system.conf(5).
      rebootTime = "5m";
      # The amount of time which can elapse when kexec is being executed before
      # a watchdog hardware device will automatically reboot the system. This
      # option should only be enabled if reloadTime is also enabled; see
      # kexec(8).
      kexecTime = "5m";
    };
  };
}
