{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.transmission
    transmission = {
      enable = true;

      package = pkgs.transmission_4;

      settings = {
        # https://github.com/transmission/transmission/wiki/Editing-Configuration-Files
        peer-port-random-on-start = true;
      };
    };
  };
}
