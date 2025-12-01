{ ... }:

{
  imports = [
    ./vcs # ./vcs/default.nix

    ./identity.nix

    ./editor.nix
    ./information.nix
    ./nix.nix
    # TODO ./tracing.nix once it builds
    ./tools.nix

    # Non-default subsystems
    # ./hardware_information.nix
    # ./watchdog.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/system/dbus.nix
  services.dbus.implementation = "broker";

  # systemd.user.settings
  systemd = {
    # /etc/systemd/user.conf

    user = {
      # https://search.nixos.org/options?channel=unstable&show=systemd.user.extraConfig
      extraConfig = ''
        # https://www.mankier.com/5/systemd-system.conf

        # https://www.mankier.com/5/systemd-system.conf#Timeouts_and_Rate_Limits
        DefaultTimeoutStartSec=5s
        DefaultTimeoutStopSec=20s
        DefaultTimeoutAbortSec=20s
        # DefaultRestartSec=100ms
      '';
    };
  };
}
