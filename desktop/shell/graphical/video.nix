{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vlc

      jellyfin-web

      blender
      kdePackages.kdenlive

      ffmpeg
    ];
  };
}
