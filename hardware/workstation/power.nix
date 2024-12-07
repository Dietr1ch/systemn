{ lib, ... }:

{
  imports = [
    ../power.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=powerManagement
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };
}
