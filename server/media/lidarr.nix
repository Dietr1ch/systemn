{ config, lib, ... }:

# MISSING: https://wiki.nixos.org/wiki/Lidarr
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.lidarr
    lidarr = {
      enable = true;
    }; # ..services.lidarr

    nginx = {
      virtualHosts = {

        # lidarr.$HOSTNAME.$DOMAIN
        "lidarr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # lidarr.$HOSTNAME.local
              "lidarr.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.lidarr.settings.server.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/lidarr.nix)
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
      "lidarr" = {
        isNormalUser = false;
        group = "lidarr";
        extraGroups = [ "media" ];
      }; # ..users.users."lidarr"
    }; # ..users.users

    groups = {
      "lidarr" = { };
    }; # ..users.groups
  }; # ..users
}
