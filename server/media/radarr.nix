{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Radarr
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.radarr
    radarr = {
      enable = true;
    }; # ..services.radarr

    nginx = {
      virtualHosts = {

        # radarr.$HOSTNAME.$DOMAIN
        "radarr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # radarr.$HOSTNAME.local
              "radarr.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.radarr.settings.server.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/radarr.nix)
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

  users = {
    users = {
      "radarr" = {
        extraGroups = [ "media" ];
      }; # ..users.users."radarr"
    }; # ..users.users
  }; # ..users
}
