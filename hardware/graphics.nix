{ ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.graphics
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
