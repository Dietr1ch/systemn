{ lib, ... }:

{
  services = {
    displayManager = {
      # https://search.nixos.org/options?channel=unstable&query=services.displayManager.plasma-login-manager
      # ~/Projects/nixpkgs/nixos/modules/services/display-managers/plasma-login-manager.nix
      plasma-login-manager = {
        enable = true;

        # https://search.nixos.org/options?channel=unstable&query=services.displayManager.plasma-login-manager.settings
        # man:plasmalogin.conf (5)
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
}
