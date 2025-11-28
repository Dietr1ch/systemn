{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.yggdrasil
    yggdrasil = {
      enable = true;

      # /run/keys/yggdrasil.conf
      settings = {

      };
    };

    # https://search.nixos.org/options?channel=unstable&query=services.yggdrasil-jumper
    # https://github.com/one-d-wide/yggdrasil-jumper
    yggdrasil-jumper = {
      enable = true;

      settings = {
        # listen_port = 9999;
        # wireguard = true;

        # List of peering protocols
        # Supported are "tcp", "quic", "tls"
        # yggdrasil_protocols = [ "tcp", "quic" ]

        # whitelist = [
        #   "<IPv6 address of a remote node>"
        # ];
      };
    };
  };
}
