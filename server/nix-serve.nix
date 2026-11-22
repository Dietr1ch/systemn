{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=nix-serve
    nix-serve = {
      enable = true;

      package = pkgs.nix-serve-ng; # https://github.com/aristanetworks/nix-serve-ng

      # Listens on http://127.0.0.1:5000
      bindAddress = "127.0.0.1";
      port = 5000;

      openFirewall = true;
      extraParams = lib.concatStringsSep " " [
        "--priority 35" # Slightly higher priority than https://cache.nixos.org/nix-cache-info
      ];

      # ../secrets.nix
      # Generate keys with,
      # sudo nix-store \
      #   --generate-binary-cache-key \
      #   "nix-store--$(hostname)" \
      #   /var/nix-store-private.pem \
      #   /var/nix-store-public.pem
      # secretKeyFile = "/var/nix-store-private.pem";
    }; # ..services.nix-serve

    nginx = {
      virtualHosts = {
        # nix.$HOSTNAME.$DOMAIN
        "nix.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases = [
            # nix.$HOSTNAME.local
            "nix.${config.networking.hostName}.local"
          ];

          locations = {
            "/" = {
              proxyPass = "http://localhost:${toString config.services.nix-serve.port}/";

              # proxyWebsockets = true;
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

        # TODO: Drop $HOSTNAME.$DOMAIN/nix vHost once we switch to nix.$HOSTNAME.$DOMAIN
        # $HOSTNAME.$DOMAIN/nix
        "${config.networking.hostName}" = {
          locations = {
            "/nix/" = {
              proxyPass = "http://localhost:${toString config.services.nix-serve.port}/";

              # proxyWebsockets = true;
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
      };
    }; # ..services.nginx
  }; # ..services
}
