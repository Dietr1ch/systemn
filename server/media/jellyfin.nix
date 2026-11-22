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
                # SystemN (~/Projects/systemn/server/media/jellyfin.nix)
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
