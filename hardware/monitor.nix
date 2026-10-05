{ pkgs, ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.ddccontrol
    ddccontrol = {
      # NOTE: This results in too much i2c chatter and disruptms the amdgpu driver
      # enable = true;
    }; # ..services.ddccontrol
  }; # ..services

  environment = {
    variables = {
      "DDCCONTROL_NO_DAEMON" = "1";
    };

    systemPackages = with pkgs; [
      ddccontrol
      ddccontrol-db
    ]; # ..environment.systemPackages
  }; # ..environment
}
