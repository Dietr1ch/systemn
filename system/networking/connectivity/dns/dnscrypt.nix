{
  lib,
  pkgs,
  ...
}:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.dnscrypt-proxy2
    #
    # Listens DNS on 127.0.0.56:53
    dnscrypt-proxy2 = {
      enable = true;

      # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
      settings = {
        listen_addresses = [
          "127.0.0.56:53"
        ];
        ipv4_servers = true;
        ipv6_servers = true;
        require_dnssec = true;

        odoh_servers = false;

        # cache_min_ttl = 1 * 24 * 60 * 60;
        cache_max_ttl = 3 * 24 * 60 * 60;

        sources = {
          # ../../../secrets.nix
          # public-resolvers = {
          # };
        };
      };
    }; # ..services.dnscrypt-proxy2

    opensnitch = {
      # https://github.com/evilsocket/opensnitch/wiki/Rules
      rules = {

        # Intent: DNSCrypt binary can reach out everywhere
        "0-ALLOW-DNSCrypt" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-ALLOW-DNSCrypt";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          # TODO: Only allow DNSCrypt on port 443 + variants (.443, 443., ...)
          operator = {
            operand = "process.path";

            data = "${lib.getBin pkgs.dnscrypt-proxy2}/dnscrypt-proxy";
            type = "simple";
          };
        }; # "0-ALLOW-DNSCrypt"

      }; # ..services.opensnitch.rules
    }; # ..services.opensnitch
  }; # ..services

  systemd = {
    services = {
      dnscrypt-proxy2 = {
        serviceConfig = {
          StateDirectory = "dnscrypt-proxy";
          ReadWritePaths = "/var/lib/dnscrypt-proxy"; # Cache directory for dnscrypt-proxy2, persist this
        };
      }; # ..systemd.services.dnscrypt-proxy2
    }; # ..systemd.services
  }; # ..systemd
}
