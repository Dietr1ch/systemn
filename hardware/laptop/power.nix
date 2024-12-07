{ lib, ... }:

{
  imports = [
    ../power.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=powerManagement
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.thermald
    thermald = {
      enable = lib.mkDefault true;
    };
  };
}
