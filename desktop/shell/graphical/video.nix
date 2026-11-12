{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vlc

      jellyfin-web
      jellyfin-ffmpeg

      blender
      kdePackages.kdenlive

      ffmpeg
    ];
  };
}
