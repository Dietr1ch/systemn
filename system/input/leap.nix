{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      input-leap
    ]; # ..environment.systemPackages
  }; # ..environment

  networking = {
    firewall = {
      allowedTCPPorts = [
        24800
      ];
    }; # ..networking.firewall
  }; # ..networking
}
