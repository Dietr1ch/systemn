{ config, pkgs, ... }:

# https://wiki.nixos.org/wiki/Jellyfin
# https://nixos.wiki/wiki/Jellyfin
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.jellyfin
    jellyfin = {
      enable = true;
      # port = 8096
    }; # ..services.jellyfin

    # https://search.nixos.org/options?channel=unstable&query=services.seerr
    seerr = {
      enable = true;
    }; # ..services.seer

    # https://search.nixos.org/options?channel=unstable&query=services.sonarr
    sonarr = {
      enable = true;
    }; # ..services.sonarr

    nginx = {
      virtualHosts = {
        # jellyfin.$HOSTNAME.$DOMAIN
        "jellyfin.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases = [
            # jellyfin.$HOSTNAME.local
            "jellyfin.${config.networking.hostName}.local"
          ];

          # enableACME = true;
          # forceSSL = true;
          locations = {
            "/" = {
              # proxyPass = "http://localhost:${toString config.services.jellyfin.port}";
              proxyPass = "http://localhost:8096";
              proxyWebsockets = true;
              recommendedProxySettings = true;

              # /etc/nginx/nginx.conf
              extraConfig = ''
                # SystemN (~/Projects/systemn/server/nix-serve.nix)
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

        # seerr.$HOSTNAME.$DOMAIN
        "seerr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases = [
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
                # SystemN (~/Projects/systemn/server/nix-serve.nix)
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

        # sonarr.$HOSTNAME.$DOMAIN
        "sonarr.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases = [
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
                # SystemN (~/Projects/systemn/server/nix-serve.nix)
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

  environment = {
    systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ]; # ..environment.systemPackages
  }; # ..environment
}
