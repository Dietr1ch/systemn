{ pkgs, lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.hyprland
    hyprland = {
      enable = true;

      xwayland.enable = lib.mkDefault false; # TODO: Drop xwayland when feasible
      withUWSM = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # Required packages
      kitty

      brightnessctl
      playerctl
      swaylock
      wofi

      wayland-protocols
      hyprland-protocols

      hyprcursor
      hyprland-activewindow
      hyprpaper
      hyprpolkitagent
      hyprsysteminfo
      rofi
      waybar
    ];
  };
}
