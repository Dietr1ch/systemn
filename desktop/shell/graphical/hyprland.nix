{ pkgs, lib, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.hyprland
    hyprland = {
      enable = true;

      xwayland.enable = lib.mkDefault false;  # TODO: Drop xwayland when feasible
      withUWSM = true;
    };
  };
}
