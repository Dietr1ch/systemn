{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./cgroups.nix
    ./limits.nix
    # ./yubikey.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=security
  security = {
    # https://search.nixos.org/options?channel=unstable&query=security.auditd
    auditd = {
      enable = true;
    };
    # https://search.nixos.org/options?channel=unstable&query=security.sudo-rs
    sudo-rs = {
      enable = true;
    };
  };
}
