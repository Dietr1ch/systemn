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
      plasma6 = {
        enable = true;
        enableQt5Integration = true;
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      kdePackages.plasma-pa
      kdePackages.plasma-nm

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
  qt = {
    enable = true;
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

