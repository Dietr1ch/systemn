{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vlc

      blender
      kdePackages.kdenlive

      ffmpeg-full
    ];
  };
}
