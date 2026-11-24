{ config, lib, ... }:

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

          # https://grafana.com/tutorials/run-grafana-behind-a-proxy/
          domain = lib.mkDefault "grafana.${config.networking.hostName}.${config.networking.domain}";

          # Alternatively, if you want to serve Grafana from a subpath:
          # Served from /grafana
          # serve_from_sub_path = true;
          # domain = "${config.networking.hostName}.local";
          # root_url = "https://${config.networking.hostName}.local/grafana/";
        };

        analytics.reporting_enabled = false; # No phoning home
      }; # ..services.grafana.settings
    }; # ..services.grafana

    nginx = {
      virtualHosts = {

        # grafana.$HOSTNAME.$DOMAIN
        "grafana.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # grafana.$HOSTNAME.local
              "grafana.${config.networking.hostName}.local"
            ];

          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.grafana.settings.server.http_port}";

              # proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/grafana.nix)
                # -------
                keepalive_timeout 300;
                proxy_max_temp_file_size 0;
                sendfile           on;
                sendfile_max_chunk 1m;
                tcp_nodelay       on;
                tcp_nopush on;
              '';
            };
          };
        };

      }; # ..services.nginx.virtualHosts
    }; # ..services.nginx
  }; # ..services
}
