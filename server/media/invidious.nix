{ config, lib, ... }:

# MISSING: https://wiki.nixos.org/wiki/Invidious
# https://invidious.io/
# https://docs.invidious.io/
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.invidious
    invidious = {
      enable = true;

      address = "127.0.0.1";

      # https://github.com/iv-org/invidious/blob/master/config/config.example.yml
      # settings = {
      #   "https_only" = false;
      # };
    }; # ..services.invidious

    nginx = {
      virtualHosts = {

        # invidious.$HOSTNAME.$DOMAIN
        "invidious.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases =
            [ ]
            ++ lib.optionals (config.networking.domain != "local") [
              # invidious.$HOSTNAME.local
              "invidious.${config.networking.hostName}.local"
            ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.invidious.port}";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/media/invidious.nix)
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
      "invidious" = {
        isSystemUser = true;
        group = "invidious";
        extraGroups = [ "media" ];
      }; # ..users.users."invidious"
    }; # ..users.users

    groups = {
      "invidious" = { };
    }; # ..users.groups
  }; # ..users
}
