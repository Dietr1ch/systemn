{ ... }:

{
  systemd = {
    coredump = {
      enable = true;

      # /etc/systemd/coredump.conf
      # man coredump.conf(5)
      extraConfig = ''
        # SystemN configuration
        # ---------------------
        # ~/Projects/systemn/system/base/crashes.nix

        Storage=external  # external: /var/lib/systemd/coredump/
        Compress=yes
        ProcessSizeMax=1G
        ExternalSizeMax=1G
      '';
    };
  };
}
