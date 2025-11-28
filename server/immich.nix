{ ... }:

# TODO: Configure Immich
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.immich
    immich = {
      enable = true;

      # https://immich.app/docs/install/config-file/
      settings = {
      };
    };
  };
}
