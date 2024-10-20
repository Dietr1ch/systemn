{ config, lib, pkgs, ... }:

# Intended setup:
#
# NetworkManager
# > ResolvConf
#   > resolved              | 127.0.0.53,127.0.0.54
#     > avahi
#     > adguardhome         | 127.0.0.55 Upstream filtering rules
#       > DNSCrypt-proxy2   | 127.0.0.56 static filtering
#         > (Friendly peer DNSCrypt-proxy2)
#         > (Internet)
# ≯ systemd-resolved (disabled)

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.resolved
    #
    # Listens DNS on 127.0.0.53:53 and 127.0.0.54:53
    resolved = {
      enable = lib.mkDefault true;

      # Setting fallbackDns to avoid default list
      fallbackDns = [
        "127.0.0.55"  # adguardhome
        # "127.0.0.56"  # dnscrypt-proxy2 (behind adguardhome already)
      ];
    };

    # https://search.nixos.org/options?channel=unstable&query=services.avahi
    avahi = {
      enable = lib.mkDefault true;

      ipv4 = true;
      ipv6 = true;

      nssmdns4 = true;
      # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv6.
      # Enabling it allows applications to resolve names in the .local domain by
      # transparently querying the Avahi daemon.
      # Due to the fact that most mDNS responders only register local IPv4
      # addresses, most user want to leave this option disabled to avoid long
      # timeouts when applications first resolve the none existing IPv6 address.
      nssmdns6 = false;

      openFirewall = true;

      publish = {
        enable = true;

        addresses = true;
        workstation = true;  # Register a service of type “_workstation._tcp” on the local LAN.
        userServices = true;
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=services.adguardhome
    #
    # Listens DNS on 127.0.0.55:53
    adguardhome = {
      enable = true;

      # Web UI: http://127.0.0.1:3053
      host = "127.0.0.1";
      port = 3053;
      mutableSettings = false;

      # https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file
      settings = {
        enable = true;

        dns = {
          # Serve on 127.0.0.55:53
          bind_hosts = [
            "127.0.0.55"
          ];
          port = 53;

          upstream_dns = [
            "127.0.0.56:53"  # dnscrypt-proxy2
          ];
        };
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
        };
        # ../../../secrets.nix
        filters = map(url: { enabled = true; url = url; }) [
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"  # The Big List of Hacked Malware Web Sites
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"  # malicious url blocklist
        ];
      };
    };

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
    };
  };


  # https://nixos.wiki/wiki/Networking
  networking = {
    enableIPv6 = true;

    # https://search.nixos.org/options?channel=unstable&query=networking.nameservers
    nameservers = [
      # NOTE: Can't use specify ports (:53) as it breaks bandwhich's resolve.conf parsing.

      # Host DNS
      "127.0.0.55"  # adguardhome
      # "127.0.0.56"  # dnscrypt-proxy2 (behind adguardhome already)

      # Local DNS
      # "192.168.1.31"

      # Remote
      # Cloudflare IPv4 DNS
      # "1.1.1.1"
      # "1.0.0.1"
      # Google IPv4 DNS
      # "8.8.8.8"
      # "8.8.4.4"
    ];

    hosts = {
      # "::1" = [
      #   "${config.networking.hostName}"
      #   "${config.networking.hostName}.local"
      # ];
      # "127.0.0.2" = [
      #   "${config.networking.hostName}"
      #   "${config.networking.hostName}.local"
      # ];

      "127.0.0.99" = [
        # https://github.com/hagezi/dns-blocklists

        # Surveillance
        "analytics.tiktok.com"
        "awstrack.me"

        "incoming.telemetry.mozilla.org"

        "ac.duckduckgo.com"
        "links.duckduckgo.com"
        "google-analytics.com"
        "www.google-analytics.com"
      ];
    };

    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      enable = true;

      dns = lib.mkDefault "none";

      connectionConfig = {
        # Enable mdns resolution for resolved on all connections
        # See https://man.archlinux.org/man/NetworkManager.conf.5#CONNECTION_SECTION
        "connection.mdns" = 2;
      };
    };

    # https://search.nixos.org/options?channel=unstable&query=networking.resolvconf
    resolvconf = {
      useLocalResolver = false;
    };
  };

  systemd = {
    services = {
      dnscrypt-proxy2 = {
        serviceConfig = {
          StateDirectory = "dnscrypt-proxy";
          ReadWritePaths = "/var/lib/dnscrypt-proxy"; # Cache directory for dnscrypt-proxy2, persist this
        };
      };
    };
  };
}
