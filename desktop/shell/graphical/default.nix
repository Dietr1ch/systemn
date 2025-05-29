{ pkgs, ... }:

{
  imports = [
    ./fonts.nix

    ./login-sddm.nix

    # ./hyprland.nix
    ./plasma.nix
  ];

  services = {
    colord = {
      enable = true;
    };
  };

  environment = {
    variables = {
      # SDL2 (https://github.com/libsdl-org/SDL/blob/SDL2/include/SDL_hints.h)
      "SDL_VIDEODRIVER" = "wayland";
      "SDL_AUDIODRIVER" = "pipewire";
      # SDL3 (https://github.com/libsdl-org/SDL/blob/main/include/SDL3/SDL_hints.h)
      "SDL_VIDEO_DRIVER" = "wayland";
      "SDL_AUDIO_DRIVER" = "pipewire";

      "QT_QPA_PLATFORM" = "wayland";
      "ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
    };
  };
}

