{ pkgs, lib, ... }:

{
  security.rtkit.enable = true;

  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.pipewire
    pipewire = {
      enable = true;
      audio.enable = true;

      jack.enable = true;

      wireplumber = {
        enable = true;
        extraLv2Packages = with pkgs; [
          lsp-plugins # https://search.nixos.org/packages?channel=unstable&query=lsp-plugins
        ];
      };

      extraConfig = {
        pipewire = {

          "99-disable-x11-bell" = {
            "context.properties" = {
              "module.x11.bell" = lib.mkDefault false;
            };
          }; # ..services.pipewire.extraConfig.pipewire."99-disable-x11-bell"

        }; # ..services.pipewire.extraConfig.pipewire
      }; # ..services.pipewire.extraConfig

    }; # ..services.pipewire
  }; # ..services

  environment = {
    systemPackages = with pkgs; [
      wiremix

      # Tools
      ffmpeg-full
      # FIXME https://github.com/NixOS/nixpkgs/issues/493680
      # BROKEN: flacon
      shntool
      sox

      beets
      python314Packages.beets
      python314Packages.beetcamp
    ]; # ..environment.systemPackages
  }; # ..environment
}
