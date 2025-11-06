{ pkgs, ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.graphics
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      libGL
      egl-wayland
    ];
  };
}
