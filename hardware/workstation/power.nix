{ lib, ... }:

{
  imports = [
    ../power.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=powerManagement
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  networking = {
    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      # /etc/NetworkManager/NetworkManager.conf::connection
      # https://networkmanager.dev/docs/api/latest/NetworkManager.conf.html
      connectionConfig = {
        "ethernet.wake-on-lan" = lib.mkDefault "magic";
        "wifi.wake-on-lan" = lib.mkDefault "ignore";
      };
    };
  };
}
