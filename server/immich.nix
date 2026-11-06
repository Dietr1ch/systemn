{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Immich

# System Configuration:
#
# services = {
#   # https://search.nixos.org/options?channel=unstable&query=services.immich
#   immich = {
#     # http://my_machine.local:2283/
#     host = "0.0.0.0";
#     port = 2283;
#     openFirewall = true;
#
#     # Data
#     mediaLocation = "/var/lib/immich";  # Must be owned by immich:immich
#     # https://search.nixos.org/options?channel=unstable&query=services.immich.database
#     database = {
#       host = "/run/postgresql";
#       port = 5432;
#     };
#     # https://search.nixos.org/options?channel=unstable&query=services.immich.redis
#     redis = {
#       host = config.services.redis.servers.immich.unixSocket;
#       port = 0;
#     };
#
#     # https://immich.app/docs/install/config-file/
#     settings = {
#       server = {
#         externalDomain = "${config.networking.hostName}.local";
#       }; # ..services.immich.server
#     }; # ..services.immich.settings
#
#     # https://docs.immich.app/install/environment-variables/
#     environment = {
#       "CPU_CORES" = 4;
#       "IMMICH_LOG_LEVEL" = "log";
#     }; # ..services.immich.environment
#
#     machine-learning = {
#       # https://docs.immich.app/install/environment-variables/#machine-learning
#       environment = {
#         "MACHINE_LEARNING_MODEL_TTL" = "600";
#       };
#     }; # ..services.immich.machine-learning
#
#     accelerationDevices = null;  # Allow all devices
#     # accelerationDevices = [];  # Allow no devices
#
#   }; # ..services.immich
# }; # ..services

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.immich
    immich = {
      enable = true;

      # https://immich.app/docs/install/config-file/
      settings = { };
    }; # ..services.immich

    # immich-public-proxy = {
    # }; # ..services.immich-public-proxy
    # immich-kiosk = {
    # }; # ..services.immich-kiosk
    # immichframe = {
    # }; # ..services.immichframe

    nginx = {
      virtualHosts = {
        # immich.$HOSTNAME
        "immich.${config.networking.hostName}" = {
          # enableACME = true;
          # forceSSL = true;
          locations."/" = {
            proxyPass = "http://[::1]:${toString config.services.immich.port}";
            proxyWebsockets = true;
            recommendedProxySettings = true;
            extraConfig = ''
              client_max_body_size 50000M;
              proxy_read_timeout   600s;
              proxy_send_timeout   600s;
              send_timeout         600s;
            '';
          };
        };
      }; # ..services.nginx.virtualHosts
    }; # ..services.nginx
  }; # ..services

  systemd = {
    services = {
      # man:systemd.unit
      # man:systemd.service
      "immich-server" = {
        unitConfig = {
          RequiresMountsFor = lib.concatStringsSep " " [ config.services.immich.mediaLocation ];
        }; # ..systemd.services."immich".Service

        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          # Resource Control
          # ----------------
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html#CPUQuota
          # Limit overall CPU usage to 60% per core
          CPUQuota = lib.mkDefault "${toString (60 * config.nix.settings.cores)}%";
        };
      }; # ..systemd.services."immich"
      "immich-machine-learning" = {
        unitConfig = {
          RequiresMountsFor = lib.concatStringsSep " " [ config.services.immich.mediaLocation ];
        }; # ..systemd.services."immich".Service

        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          # Resource Control
          # ----------------
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html#CPUWeight=weight
          CPUWeight = "idle";
          # https://www.freedesktop.org/software/systemd/man/latest/systemd.resource-control.html#CPUQuota
          # Limit overall CPU usage to 60% per core
          CPUQuota = lib.mkDefault "${toString (60 * config.nix.settings.cores)}%";
        };
      }; # ..systemd.services."immich"
    }; # ..systemd.services
  }; # ..systemd

  users = {
    users = {
      "immich" = {
        extraGroups = [
          "video"
          "render"
        ];
      }; # ..users.users."immich"
    }; # ..users.users
  }; # ..users
}
