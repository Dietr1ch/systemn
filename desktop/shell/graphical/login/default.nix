{ ... }:

{
  imports = [
    ./plasma.nix
    # ./sddm.nix
  ];

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
