{ lib, ... }:

{
  powerManagement = {
    enable = true;

    powertop = {
      enable = true;
    };
  };

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.acpid
    acpid = {
      enable = true;
    };
  };
}
