{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      gimp
      inkscape
      kdePackages.gwenview
      krita

      ffmpeg-full
    ];
  };
}
