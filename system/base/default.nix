{ ... }:

{
  imports = [
    ./vcs # ./vcs/default.nix

    ./identity.nix

    ./crashes.nix
    ./editor.nix
    ./hacks.nix
    ./hardware_information.nix
    ./information.nix
    ./logs.nix
    ./nix.nix
    # TODO ./tracing.nix once it builds
    ./tools.nix
    # ./watchdog.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/system/dbus.nix
  services.dbus.implementation = "broker";

  systemd = {
    user = {
      # /etc/systemd/user.conf
      settings = {
        Manager = {
          # https://www.mankier.com/5/systemd-system.conf

          # https://www.mankier.com/5/systemd-system.conf#Timeouts_and_Rate_Limits
          "DefaultTimeoutStartSec" = "5s";
          "DefaultTimeoutStopSec" = "20s";
          "DefaultTimeoutAbortSec" = "20s";
          # "DefaultRestartSec"="100ms";
        };
      };
    };
  };
}
