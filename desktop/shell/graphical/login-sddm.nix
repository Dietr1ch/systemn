{ pkgs, ... }:

{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  systemd = {
    services = {
      display-manager = {
        # https://www.freedesktop.org/software/systemd/man/systemd.service.html
        serviceConfig = {
          "OOMScoreAdjust" = -800;
        };
      };
    };
  };
}
