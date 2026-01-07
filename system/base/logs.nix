{ ... }:

{
  services = {
    # https://search.nixos.org/options?channel=unstable&query=services.journald
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/system/boot/systemd/journald.nix
    journald = {
      # /etc/systemd/journald.conf
      # man journald.conf(5)
      extraConfig = ''
        [Journal]
        SystemMaxUse=100M
        MaxRetentionSec=1week
      '';
    };
  };
}
