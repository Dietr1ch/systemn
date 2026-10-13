{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.adguardhome
    #
    # Listens DNS on 127.0.0.55:53
    adguardhome = {
      enable = true;

      mutableSettings = false;

      # https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file
      settings = {
        enable = true;

        http = {
          # Web UI: http://127.0.0.1:3053
          address = "127.0.0.1:3053";
        }; # ..services.adguardhome.settings.http

        dns = {
          # Serve on 127.0.0.55:53
          bind_hosts = [ "127.0.0.55" ];
          port = 53;

          upstream_dns = [
            "127.0.0.56:53" # dnscrypt-proxy
          ];
        }; # ..services.adguardhome.settings.dns
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
        }; # ..services.adguardhome.settings.filtering

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
      }; # ..services.adguardhome.settings
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
