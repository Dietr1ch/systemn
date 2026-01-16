{ pkgs, ... }:

{
  imports = [
    ./browser # ./browser/default.nix

    # ./env/hyprland.nix
    # ./env/dms.nix
    ./env/plasma.nix

    # ./audio.nix
    # ./cad.nix
    ./comms.nix
    ./fonts.nix
    # ./guitar.nix
    # ./images.nix
    ./login-sddm.nix
    # ./office.nix
    ./tools.nix
    # ./video.nix
  ];

  services = {
    colord = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      alacritty

      filezilla
      vlc

      vkdevicechooser
      vkdisplayinfo

      vokoscreen-ng
    ];

    variables = {
      # SDL2 (https://github.com/libsdl-org/SDL/blob/SDL2/include/SDL_hints.h)
      "SDL_VIDEODRIVER" = "wayland";
      "SDL_AUDIODRIVER" = "pipewire";
      # SDL3 (https://github.com/libsdl-org/SDL/blob/main/include/SDL3/SDL_hints.h)
      "SDL_VIDEO_DRIVER" = "wayland";
      "SDL_AUDIO_DRIVER" = "pipewire";

      "ELECTRON_OZONE_PLATFORM_HINT" = "wayland";
      "NIXOS_OZONE_WL" = "1";
      "QT_QPA_PLATFORM" = "wayland";
    };
  };

  xdg = {
    # man portals.conf(5)
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    sounds = {
      enable = true;
    };

    terminal-exec = {
      enable = true;
      settings = {
        "default" = [
          "alacritty.desktop"
        ];
      };
    };
  };
}
