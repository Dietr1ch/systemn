{ lib, ... }:

{
  imports = [
    ../power.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=powerManagement
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  networking = {
    # https://search.nixos.org/options?channel=unstable&query=networking.networkmanager
    networkmanager = {
      # /etc/NetworkManager/NetworkManager.conf::connection
      # https://networkmanager.dev/docs/api/latest/NetworkManager.conf.html
      connectionConfig = {
        "ethernet.wake-on-lan" = lib.mkDefault "ignore";
        "wifi.wake-on-lan" = lib.mkDefault "ignore";
      };
    };
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.thermald
    thermald = {
      enable = lib.mkDefault true;
    };
  };
}
