{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      blender-hip
      kdePackages.kdenlive

      ffmpeg
    ];
  };
}
