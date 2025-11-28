{ ... }:

# TODO: Configure TOR
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.tor
    tor = {
      enable = true;
    };
  };
}
