{ config, lib, ... }:

# https://wiki.nixos.org/wiki/Prometheus
# https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.prometheus
    prometheus = {
      enable = true;

      # Listens on http://localhost:9090/
      # listenAddress = "0.0.0.0";
      # port = 9090;

      # retentionTime = lib.mkDefault "15d";

      # https://search.nixos.org/options?channel=unstable&query=services.prometheus.globalConfig
      globalConfig = {
        scrape_interval = lib.mkDefault "10s";
      };

      exporters = {
        # https://search.nixos.org/options?channel=unstable&query=services.prometheus.exporters.node
        node = {
          enable = true;

          # Listens on http://localhost:9100/
          # listenAddress = "0.0.0.0";
          # port = 9100;

          # Collectors in addition to the default ones,
          # - https://github.com/prometheus/node_exporter#enabled-by-default
          # - https://github.com/prometheus/node_exporter#disabled-by-default
          enabledCollectors = [
            "processes"
            "systemd"
          ];
        };
      };

      # https://search.nixos.org/options?channel=unstable&query=services.prometheus.scrapeConfigs
      scrapeConfigs = [
        {
          job_name = "self-node";
          static_configs = [
            {
              targets = [
                "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
              ];
            }
          ];
        }
      ];

    };
  };
}
