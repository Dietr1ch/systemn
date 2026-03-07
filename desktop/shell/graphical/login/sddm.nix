{ pkgs, lib, ... }:

{
  services = {
    displayManager = {
      # https://search.nixos.org/options?channel=unstable&query=services.displayManager.sddm
      # ~/Projects/nixpkgs/nixos/modules/services/display-managers/sddm.nix
      sddm = {
        enable = true;

        # ThemeDir = "/run/current-system/sw/share/sddm/themes";
        # FacesDir = "/run/current-system/sw/share/sddm/faces";
        # theme = ??;

        wayland = {
          enable = true;
        };

        # https://search.nixos.org/options?channel=unstable&query=services.displayManager.sddm.settings
        # man sddm.conf (5)
        settings = {
          General = {
            NumLock = lib.mkDefault "on";
          };
        };

        autoNumlock = true;

        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
        ];
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
