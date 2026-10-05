{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.ddccontrol
    ddccontrol = {
      enable = true;
    }; # ..services.ddccontrol
  }; # ..services

  environment = {
    systemPackages = with pkgs; [
      ddccontrol
      ddccontrol-db
    ]; # ..environment.systemPackages
  }; # ..environment
}
