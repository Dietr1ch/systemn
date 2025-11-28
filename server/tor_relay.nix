{ lib, ... }:

# TODO: Configure TOR relay
{
  services = {
    tor = {
      # https://search.nixos.org/options?channel=unstable&query=services.tor.relay
      relay = {
        enable = true;

        # https://community.torproject.org/relay/community-resources/eff-tor-legal-faq/
        role = lib.mkDefault "relay";
      };
    };
  };
}
