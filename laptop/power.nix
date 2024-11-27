{ config, lib, pkgs, ... }:

{
  # https://search.nixos.org/options?channel=unstable&query=powerManagement
  powerManagement = {
    enable = true;

    powertop = {
      enable = true;
    };

    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  # services = {
  #   # https://search.nixos.org/options?channel=unstable&query=services.acpid
  #   acpid = {
  #     enable = true;
  #   };
  #   # https://search.nixos.org/options?channel=unstable&query=services.thermald
  #   thermald = {
  #     enable = true;
  #   };
  # };
}
