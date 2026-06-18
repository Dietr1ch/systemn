{ ... }:

{
  services = {
    displayManager = {
      # https://search.nixos.org/options?channel=unstable&query=services.displayManager.plasma-login-manager
      # ~/Projects/nixpkgs/nixos/modules/services/display-managers/plasma-login-manager.nix
      plasma-login-manager = {
        enable = true;
      };
    };
  };

  systemd = {
    services = {
      display-manager = {
        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          "OOMScoreAdjust" = -800;
        };
      };
    };
  };
}
