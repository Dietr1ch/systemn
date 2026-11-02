{ lib, ... }:

{
  services = {
    displayManager = {
      # https://search.nixos.org/options?channel=unstable&query=services.displayManager.plasma-login-manager
      # ~/Projects/nixpkgs/nixos/modules/services/display-managers/plasma-login-manager.nix
      plasma-login-manager = {
        enable = true;

        # https://search.nixos.org/options?channel=unstable&query=services.displayManager.plasma-login-manager.settings
        # man:plasmalogin.conf(5)
        # - /etc/plasmalogin.conf
        # - /etc/plasmalogin.conf.d/
        #   - /etc/plasmalogin.conf.d/00-nixos-defaults.conf
        #   - /etc/plasmalogin.conf.d/99-user.conf
        settings = {
          General = {
            NumLock = lib.mkDefault "on";
          };
        }; # ..services.displayManager.plasma-login-manager.settings
      }; # ..services.displayManager.plasma-login-manager
    }; # ..services.displayManager
  }; # ..services

  systemd = {
    # https://search.nixos.org/options?channel=unstable&query=systemd.services
    services = {
      "plasmalogin" = {
        # man:systemd.service(5)
        serviceConfig = {
          Restart = "always";
          RestartSec = "4s";
          RestartSteps = "5";
          RestartMaxDelaySec = "60s";
        }; # ..systemd.services."plasmalogin".serviceConfig
      }; # ..systemd.services."plasmalogin"
    }; # ..systemd.services
  }; # ..systemd
}
