{ ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.keyboard
    keyboard = {
      qmk.enable = true;
    };
  };
}
