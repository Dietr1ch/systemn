{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vlc

      jellyfin
      jellyfin-web
      jellyfin-ffmpeg

      blender
      kdePackages.kdenlive

      ffmpeg-full
    ];
  };
}
