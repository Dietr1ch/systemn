{ config, lib, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.bazarr
    bazarr = {
      enable = true;
    }; # ..services.seer

    nginx = {
      virtualHosts = {

        # bazarr.$HOSTNAME.$DOMAIN
        "bazarr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # bazarr.$HOSTNAME.local
              "bazarr.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.bazarr.settings.general.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/bazarr.nix)
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
      "bazarr" = {
        extraGroups = [ "media" ];
      }; # ..users.users."bazarr"
    }; # ..users.users
  }; # ..users
}
