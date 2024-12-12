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
        enableQt5Integration = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # Qt
      qt6.qtwayland
      qt5.qtwayland
      kdePackages.kwayland
      libsForQt5.kwayland


      kdePackages.plasma-pa  # NOTE: Enabled through Pulse Audio, hardware.pulseaudio.enable
      kdePackages.plasma-nm  # NOTE: Enabled through NetworkManager, networking.networkmanager.(enable)

      kdePackages.kleopatra
      cryptsetup
      plasma-vault

      # Dolphin
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.kio
      kdePackages.kio-fuse
      kdePackages.kio-gdrive
      kdePackages.kio-zeroconf

      # KDE Connect
      plasma5Packages.kdeconnect-kde  # TODO consider dropping plasma5Packages.kdeconnect-kde
      kdePackages.kdeconnect-kde

      # Theme
      kdePackages.breeze
      kdePackages.breeze-icons
      kdePackages.breeze-plymouth
      kdePackages.breeze-gtk

      # Ark
      arj
      lrzip
      pbzip2
      pigz
      pixz
      xz
      zip
    ];

    plasma6 = {
      excludePackages = with pkgs.kdePackages; [
        # konsole
        elisa
        # print-manager
      ];
    };
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde
      ];
    };
  };
}

