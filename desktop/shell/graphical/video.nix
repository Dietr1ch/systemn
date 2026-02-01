{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      vlc

      blender
      # BROKEN: kdePackages.kdenlive

      ffmpeg-full
    ];
  };
}
