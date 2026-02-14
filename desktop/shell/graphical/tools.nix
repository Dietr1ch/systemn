{ pkgs, ... }:

{
  programs = {
    # https://search.nixos.org/options?channel=unstable&query=programs.ssh
    ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };

    # https://search.nixos.org/options?channel=unstable&query=programs.localsend
    localsend = {
      enable = true;
      openFirewall = true;
    }; # ..programs.localsend
  }; # ..programs

  environment = {
    systemPackages = with pkgs; [
      kdePackages.kasts # TODO: Find a new home for kasts

      transmission_4-qt6 # For pairing with ://server/transmission.nix

      gpu-viewer

      gparted
      meld
    ];
  }; # ..environment
}
