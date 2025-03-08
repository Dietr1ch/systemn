{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.syncthing
    syncthing = {
      enable = true;

      openDefaultPorts = true;

      settings = {
        options = {
          localAnnounceEnabled = true;
        }; # ..services.syncthing.settings.options
      }; # ..services.syncthing.settings

    }; # ..services.syncthing
  }; # ..services
}
