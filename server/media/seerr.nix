{ config, lib, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.seerr
    seerr = {
      enable = true;
    }; # ..services.seer

    nginx = {
      virtualHosts = {

        # seerr.$HOSTNAME.$DOMAIN
        "seerr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # seerr.$HOSTNAME.local
              "seerr.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.seerr.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/seerr.nix)
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
      "seerr" = {
        isNormalUser = false;
        group = "seerr";
        extraGroups = [ "media" ];
      }; # ..users.users."seerr"
    }; # ..users.users

    groups = {
      "seerr" = { };
    }; # ..users.groups
  }; # ..users
}
