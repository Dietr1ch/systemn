{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.journald
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/system/boot/systemd/journald.nix
    journald = {
      # /etc/systemd/journald.conf
      # man journald.conf(5)
      extraConfig = ''
        [Journal]
        SystemMaxUse=100M
        MaxRetentionSec=1week
      '';
    };
  };

  systemd = {
    services = {
      # https://search.nixos.org/options?channel=unstable&query=systemd.services.<name>.
      "downtime_logger" = {
        enable = true;
        description = "A system service to log the previous downtime on boot";

        after = [
          "systemd-journald.service"
          "systemd-time-wait-sync.service"
        ];
        requires = [
          "systemd-journald.service"
        ];

        serviceConfig = {
          "Type" = "oneshot";
          "RestartSec" = 5;
        };

        script = ''
          #!/usr/bin/env bash
          set -euo pipefail

          # Get log timestamps
          first_last=$(${pkgs.systemd}/bin/journalctl --boot -1 --output json --lines 1 | ${pkgs.jq}/bin/jq -r '.__REALTIME_TIMESTAMP')
          prev_last=$(${pkgs.systemd}/bin/journalctl --boot -1 --output json --lines +1 | ${pkgs.jq}/bin/jq -r '.__REALTIME_TIMESTAMP')
          curr_first=$(${pkgs.systemd}/bin/journalctl --boot 0 --output json --unit systemd-time-wait-sync.service --lines 1 | ${pkgs.jq}/bin/jq -r '.__REALTIME_TIMESTAMP')
          # If either is empty, exit silently
          if [[ -z "$prev_last" || -z "$curr_first" ]]; then
              exit 0
          fi

          # μs -> s
          first_last_sec=$((first_last / 1000000))
          prev_last_sec=$((prev_last / 1000000))
          curr_first_sec=$((curr_first / 1000000))

          uptime_secs=$((prev_last_sec - first_last_sec))
          uptime_human=$(printf '%dd %02dh %02dm %02ds\n' \
              $((uptime_secs/86400)) \
              $((uptime_secs%86400/3600)) \
              $((uptime_secs%3600/60)) \
              $((uptime_secs%60)))
          uptime_start=$(${pkgs.coreutils}/bin/date --date "@$first_last_sec")
          uptime_end=$(${pkgs.coreutils}/bin/date --date "@prev_first_sec")

          downtime_secs=$((curr_first_sec - prev_last_sec))
          downtime_human=$(printf '%dd %02dh %02dm %02ds\n' \
              $((downtime_secs/86400)) \
              $((downtime_secs%86400/3600)) \
              $((downtime_secs%3600/60)) \
              $((downtime_secs%60)))
          downtime_start=$(${pkgs.coreutils}/bin/date --date "@$prev_last_sec")
          downtime_end=$(${pkgs.coreutils}/bin/date --date "@$curr_first_sec")

          echo "System was up for $uptime_secs s (uptime_human) from $uptime_start to $uptime_end"
          echo "System was down for $downtime_secs s ($downtime_human) from $downtime_start to $downtime_end"
        '';
      };
    };
  };
}
