{ ... }:

{
  hardware = {
    # https://search.nixos.org/options?channel=unstable&query=hardware.bluetooth
    bluetooth = {
      enable = true;

      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };

      # NOTE: This conflicts with WirePlumber
      # https://github.com/pali/hsphfpd-prototype
      # hsphfpd.enable = true;
    };
  };
}
