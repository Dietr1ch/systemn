{ pkgs, lib, ... }:

# ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/services/desktop-managers/plasma6.nix
{
  programs = {
    # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/programs/xwayland.nix
    xwayland.enable = lib.mkDefault false;  # TODO: Drop xwayland when feasible
    # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/programs/kdeconnect.nix
    kdeconnect.enable = true;
    # TODO: Consider dropping kde-pim
    # kde-pim.enable = lib.mkForce false;  # Drop KDE PIM (KMail, Kontact, ...)
  };

  services = {
    xserver.enable = lib.mkForce false;
    orca.enable = lib.mkForce false;  # No screenreading, sorry :(
  };

  services = {
    displayManager = {
      defaultSession = "plasma";
    };

    desktopManager = {
      # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/services/desktop-managers/plasma6.nix
      plasma6 = {
        enable = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # Qt
      qt6.qtwayland
      kdePackages.kwayland

      kdePackages.plasma-pa  # NOTE: Enabled through Pulse Audio, hardware.pulseaudio.enable
      kdePackages.plasma-nm  # NOTE: Enabled through NetworkManager, networking.networkmanager.(enable)

      kdePackages.kleopatra
      cryptsetup
      kdePackages.plasma-vault

      # Dolphin
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.kio
      kdePackages.kio-fuse
      kdePackages.kio-gdrive
      kdePackages.kio-zeroconf

      # KDE Connect
      kdePackages.kdeconnect-kde

      # Theme
      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.breeze-plymouth
      kdePackages.breeze-gtk

      # Ark
      kdePackages.ark
      # TODO: Consider adding `arj` once it builds
      # arj
      lrzip
      # TODO: Consider adding `pbzip2` once it builds
      # pbzip2
      pigz
      pixz
      xz
      zip
    ];

    plasma6 = {
      excludePackages = with pkgs.kdePackages; [
        elisa
        kate
        xwaylandvideobridge
      ];
    };
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
      ];
    };
  };
}

