{ ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        # https://search.nixos.org/options?channel=unstable&query=boot.loader.systemd-boot.memtest86
        memtest86 = {
          enable = true;
        };
      };
    };
  };
}
