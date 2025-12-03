{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.fstrim
    fstrim = {
      enable = true;

      interval = "weekly";
    };
  };
}
