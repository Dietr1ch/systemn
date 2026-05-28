{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.aria2
    aria2 = {
      enable = true;

      # https://search.nixos.org/options?channel=unstable&query=services.aria2.settings
      # settings = {
      #   dir = "/var/lib/aria2/Downloads";
      # };
    }; # ..services.aria2
  }; # ..services

  environment = {
    systemPackages = with pkgs; [
      ariang
    ]; # ..environment.systemPackages
  }; # ..environment
}
