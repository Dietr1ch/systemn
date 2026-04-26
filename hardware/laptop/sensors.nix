{ ... }:

# https://wiki.nixos.org/wiki/IIO
{
  hardware = {
    sensor = {
      iio = {
        enable = true;
      };
    };
  };
}
