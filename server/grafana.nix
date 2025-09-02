{ config, ... }:

# https://wiki.nixos.org/wiki/Grafana
# https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.grafana
    grafana = {
      enable = true;

      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3990;
          enforce_domain = true;
          enable_gzip = true;
          # domain = "grafana.your.domain";

          # Alternatively, if you want to serve Grafana from a subpath:
          # Served from /grafana
          # serve_from_sub_path = true;
          # domain = "${config.networking.hostName}.local";
          # root_url = "https://${config.networking.hostName}.local/grafana/";
        };

        analytics.reporting_enabled = false; # No phoning home
      };
    };

    nginx = {
      virtualHosts = {
        "${config.networking.hostName}.local" = {
          locations = {
            "/grafana/" = {
              proxyPass =
                let
                  addr = config.services.grafana.settings.server.http_addr;
                  port = config.services.grafana.settings.server.http_port;
                in
                "http://${toString addr}:${toString port}/";
              proxyWebsockets = true;
              recommendedProxySettings = true;
            };
          };
        };
      };
    };
  };
}
