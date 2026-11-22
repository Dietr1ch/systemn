{ ... }:

# https://cromwell-intl.com/open-source/performance-tuning/tcp.html
{
  imports = [
    ./config # config/default.nix
    ./connectivity # connectivity/default.nix

    ./information.nix
    ./firewall.nix
    ./tools.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=networking
  networking = {
    # https://nixos.wiki/wiki/Systemd-networkd
    # useNetworkd = true;

    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      ethernet = {
        macAddress = "random";
      };
      wifi = {
        macAddress = "random";
        scanRandMacAddress = true;
      };
    };
    dhcpcd = {
      enable = true;

      wait = "background";

      extraConfig = ''
        noarp  # Avoid checking if the IP is taken
      '';
    };
  };
}
