{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Forgejo

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.forgejo
    forgejo = {
      enable = true;

      # https://forgejo.org/docs/latest/admin/config-cheat-sheet/
      settings = {
        service = {
          DISABLE_REGISTRATION = true; # NOTE: Temporarily allow to setup first administrator account
        };
        server = {
          # PROTOCOL = "+unix";
          # DOMAIN = "forgejo.${config.networking.hostName}.${config.networking.domain}"
          # http://localhost:9999/
          HTTP_PORT = 9999;
          SSH_PORT = lib.head config.services.openssh.ports;

          ROOT_URL = "http://forgejo.${config.networking.hostName}.${config.networking.domain}";
        };
        actions = {
          ENABLED = true;
          # DEFAULT_ACTIONS_URL = "github";
        };
        mailer = {
          # ENABLED = true;
          SMTP_ADDR = "mail.example.com";
          FROM = "noreply@${config.services.forgejo.settings.server.DOMAIN}";
          USER = "noreply@${config.services.forgejo.settings.server.DOMAIN}";
        };
      }; # ..services.forgejo.settings

      # secrets = {
      #   mailer.PASSWD = config.age.secrets.forgejo-mailer-password.path;
      # }; # ..services.forgejo.secrets
    }; # ..services.forgejo

    # Configure a single host local runner with default package set access
    # forgejo-runner = {
    #   instances = {
    #     "default" = {
    #       enable = true;
    #       runtimes.host = true;
    #
    #       settings = {
    #         runner = {
    #           labels = [
    #             # Native Execution on the Host
    #             "native:host"
    #
    #             # If Docker has been setup on the host machine
    #             # "ubuntu-latest:docker://node:16-bullseye"
    #             # "ubuntu-22.04:docker://node:16-bullseye"
    #             # "ubuntu-20.04:docker://node:16-bullseye"
    #             # "ubuntu-18.04:docker://node:16-buster"
    #           ];
    #         };
    #
    #         # server.connections.forgejo = {
    #         #   url = "https://localhost:3000"; # Forgejo Instance URL
    #         #   uuid = "aaaaaaaa-bbbbbbbbbb-cccccccccc-ddddddd"; # UUID of forgejo runner instance
    #         # };
    #       }; # ..services.forgejo-runner.instances."default".settings
    #
    #       secrets.server.connections."forgejo".token_url = "/var/lib/forgejo/forgejoToken.key"; # Path to forgejo runner key file provided by forgejo.
    #     }; # ..services.forgejo-runner.instances."default"
    #   }; # ..services.forgejo-runner.instances
    # }; # ..services.forgejo-runner

    # openssh.settings.AllowUsers = [ "forgejo" ];

    nginx = {
      virtualHosts = {
        # forgejo.$HOSTNAME.$DOMAIN
        "forgejo.${config.networking.hostName}.${config.networking.domain}" = {
          serverAliases = [
            # forgejo.$HOSTNAME.local
            "forgejo.${config.networking.hostName}.local"
          ];

          # enableACME = true;
          # forceSSL = true;
          locations."/" = {
            proxyPass =
              let
                forgejo_port = config.services.forgejo.settings.server.HTTP_PORT;
              in
              "http://localhost:${toString forgejo_port}";
            proxyWebsockets = true;
            recommendedProxySettings = true;
            extraConfig = ''
              client_max_body_size 500M;
              proxy_read_timeout   600s;
              proxy_send_timeout   600s;
              send_timeout         600s;
            '';
          };
        };
      }; # ..services.nginx.virtualHosts
    }; # ..services.nginx
  }; # ..services
}
