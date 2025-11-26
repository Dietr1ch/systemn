{ ... }:

{
  powerManagement = {
    enable = true;

    # https://search.nixos.org/options?channel=unstable&query=powerManagement.powertop
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
