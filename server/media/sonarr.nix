{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Sonarr
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.sonarr
    sonarr = {
      enable = true;
    }; # ..services.sonarr

    nginx = {
      virtualHosts = {

        # sonarr.$HOSTNAME.$DOMAIN
        "sonarr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # sonarr.$HOSTNAME.local
              "sonarr.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.sonarr.settings.server.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/sonarr.nix)
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
