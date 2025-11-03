{ ... }:

# Intended setup:
#
# NetworkManager
# > ResolvConf
#   > avahi
#   > resolved              | 127.0.0.53,127.0.0.54
#     > adguardhome         | 127.0.0.55 Upstream filtering rules
#       - Web UI: http://127.0.0.1:3053
#       > DNSCrypt-proxy   | 127.0.0.56 static filtering
#         > (Friendly peer DNSCrypt-proxy)
#         > (Internet)
# ≯ systemd-resolved (disabled)

# Firewall rules:
#
# - 0-Open-resolved:     127.0.0.*     => 127.0.0.53-54
# - 0-Allow-resolved:    127.0.0.53-54 => 127.0.0.55
# - 0-Allow-adguardhome: 127.0.0.55    => 127.0.0.56
# - 0-Allow-DNSCrypt:    127.0.0.56    => *
# - 1-RejectDNS:                  *    /> #53  (Implicit)

{
  imports = [
    ./avahi.nix

    ./resolved.nix # 127.0.0.53, 127.0.0.54
    ./adguardhome.nix # \> 127.0.0.55
    ./dnscrypt.nix # \> 127.0.0.56
  ];

  # https://nixos.wiki/wiki/Networking
  networking = {
    hosts = {
      # "::1" = [
      #   "${config.networking.hostName}"
      #   "${config.networking.hostName}.local"
      # ];
      # "127.0.0.2" = [
      #   "${config.networking.hostName}"
      #   "${config.networking.hostName}.local"
      # ];

      "127.0.0.99" = [
        # https://github.com/hagezi/dns-blocklists

        # Surveillance
        "analytics.tiktok.com"
        "awstrack.me"

        "incoming.telemetry.mozilla.org"

        "ac.duckduckgo.com"
        "links.duckduckgo.com"
        "google-analytics.com"
        "www.google-analytics.com"
      ];
    }; # ..networking.hosts
  }; # ..networking
}
