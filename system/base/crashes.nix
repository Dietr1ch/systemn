{ ... }:

{
  systemd = {
    coredump = {
      enable = true;

      # https://search.nixos.org/options?channel=unstable&query=systemd.coredump.settings
      settings = {
        # /etc/systemd/coredump.conf
        # man coredump.conf(5)
        Coredump = {
          "Storage" = "external"; # external: /var/lib/systemd/coredump/
          "Compress" = "yes";
          "ProcessSizeMax" = "1G";
          "ExternalSizeMax" = "1G";
        };
      }; # ..systemd.coredump.settings
    }; # ..systemd.coredump
  }; # ..systemd
}
