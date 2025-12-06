{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&show=programs.rust-motd
    rust-motd = {
      enable = true;

      enableMotdInSSHD = true;
      # https://github.com/rust-motd/rust-motd/blob/main/README.md#configuration
      # settings = {
      # };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      htop
      zenith

      nethogs
    ];
  };
}
