{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lynx

      yt-dlp
    ];
  };
}
