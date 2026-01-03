{ ... }:

{
  imports = [
    ./cgroups.nix
    ./crypto.nix
    ./limits.nix
    ./polkit.nix
    # ./yubikey.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=security
  security = {
    # https://search.nixos.org/options?channel=unstable&query=security.sudo-rs
    sudo-rs = {
      enable = true;

      wheelNeedsPassword = true;
      execWheelOnly = true;
    };
  };
}
