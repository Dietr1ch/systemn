{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Prowlarr
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.prowlarr
    prowlarr = {
      enable = true;
    }; # ..services.prowlarr

    nginx = {
      virtualHosts = {

        # prowlarr.$HOSTNAME.$DOMAIN
        "prowlarr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # prowlarr.$HOSTNAME.local
              "prowlarr.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.prowlarr.settings.server.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/prowlarr.nix)
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

  # NOTE: Prowlarr uses a dynamic user
}
