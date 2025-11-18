{ ... }:

{
  imports = [
    ./cgroups.nix
    ./limits.nix
    ./polkit.nix
    # ./yubikey.nix
  ];

  # https://search.nixos.org/options?channel=unstable&query=security
  security = {
    # https://nixos.wiki/wiki/Polkit
    # https://search.nixos.org/options?channel=unstable&query=security.polkit
    # polkit = {
    #   enable = true;
    # };

    # https://search.nixos.org/options?channel=unstable&query=security.auditd
    # auditd = {
    #   enable = true;
    # };
    # https://search.nixos.org/options?channel=unstable&query=security.sudo-rs
    sudo-rs = {
      enable = true;

      wheelNeedsPassword = true;
      execWheelOnly = true;
    };
  };
}
