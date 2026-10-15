{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.smartd
    smartd = {
      enable = true;

      autodetect = true;

      # devices = [
      #   {
      #     device = "/dev/nvme0";
      #     # options = "-d sat";
      #   }
      # ]; # ..services.smartd.devices
    }; # ..services.smartd
  }; # ..services
}
