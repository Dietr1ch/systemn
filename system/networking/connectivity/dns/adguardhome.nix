{ lib, pkgs, ... }:

{
  services = {
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
            "127.0.0.56:53" # dnscrypt-proxy2
          ];
        };
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
        };
        # ../../../secrets.nix
        filters =
          map
            (url: {
              enabled = true;
              url = url;
            })
            [
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
            ];
      };
    }; # ..services.adguardhome

    opensnitch = {
      # https://github.com/evilsocket/opensnitch/wiki/Rules
      rules = {

        # TODO: Whitelist DNSCrypt (127.0.0.56:53)
        # TODO: Whitelist adguardteam.github.io:443

      }; # ..services.opensnitch.rules
    }; # ..services.opensnitch
  }; # ..services
}
