{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vlc

      blender-hip
      kdePackages.kdenlive

      ffmpeg-full
    ];
  };
}
