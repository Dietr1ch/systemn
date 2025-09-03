{ pkgs, ... }:

# https://wiki.nixos.org/wiki/OBS_Studio
{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.obs-studio
    obs-studio = {
      enable = true;

      enableVirtualCamera = true;

      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-advanced-masks
        obs-backgroundremoval
        obs-gstreamer
        obs-pipewire-audio-capture
        obs-source-switcher
        obs-vaapi
        obs-vkcapture
        wlrobs
      ];
    };
  };

  environment = {
    variables = {
      "OBS_VKCAPTURE" = "1";
    };

    systemPackages = with pkgs; [
      gamemode
    ];
  };
}
