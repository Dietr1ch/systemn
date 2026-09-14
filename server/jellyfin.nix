{ pkgs, ... }:

# https://wiki.nixos.org/wiki/Jellyfin
# https://nixos.wiki/wiki/Jellyfin
{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.jellyfin
    jellyfin = {
      enable = true;
    }; # ..services.jellyfin

    seerr = {
      enable = true;
    }; # ..services.seer
  }; # ..services

  environment = {
    systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ]; # ..environment.systemPackages
  }; # ..environment
}
