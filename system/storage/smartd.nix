{ ... }:

{
  services = {
    smartd = {
      enable = true;

      # devices = [
      #   {
      #     device = "/dev/nvme0";
      #     # options = "-d sat";
      #   }
      # ];
    };
  };
}
