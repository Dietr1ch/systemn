{ pkgs, lib, ... }:

# ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/services/desktop-managers/plasma6.nix
{
  programs = {
    # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/programs/xwayland.nix
    xwayland.enable = lib.mkDefault false;  # TODO: Drop xwayland when feasible
    # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/programs/kdeconnect.nix
    # https://search.nixos.org/options?channel=unstable&query=kdeconnect
    kdeconnect.enable = true;
    # TODO: Consider dropping kde-pim
    # kde-pim.enable = lib.mkForce false;  # Drop KDE PIM (KMail, Kontact, ...)
  };

  services = {
    xserver.enable = lib.mkForce false;
    orca.enable = lib.mkForce false;  # No screenreading, sorry :(

    opensnitch = {
      # https://github.com/evilsocket/opensnitch/wiki/Rules
      # https://search.nixos.org/options?channel=unstable&query=services.opensnitch.rules
      rules = {

        # INTENT: KDEConnect can discover the local network (IPv6 ff02::/64 on port 5353)
        "0-OPEN-kdeconnect-ff02_64-5353" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-kdeconnect-ff02_64-5353";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.network";

                data = "ff02::/64";
                type = "network";
              }
              {
                operand = "dest.port";

                data = "5353";
                type = "simple";
              }
              {
                operand = "process.path";

                data = "${lib.getBin pkgs.kdePackages.kdeconnect-kde}/bin/.kdeconnectd-wrapped";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-kdeconnect-ff02_64-5353"

        # INTENT: KDEConnect can discover the local network (IPv6 fe80::/64 on port 5353)
        "0-OPEN-kdeconnect-fe80_64-5353" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-kdeconnect-fe80_64-5353";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.network";

                data = "fe80::/64";
                type = "network";
              }
              {
                operand = "dest.port";

                data = "5353";
                type = "simple";
              }
              {
                operand = "process.path";

                data = "${lib.getBin pkgs.kdePackages.kdeconnect-kde}/bin/.kdeconnectd-wrapped";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-kdeconnect-fe80_64-5353"

        # INTENT: KDEConnect can discover the local network (IPv4 224.0.0.0/24 on port 5353)
        "0-OPEN-kdeconnect-224-5353" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-kdeconnect-224-5353";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.network";

                data = "224.0.0.0/24";
                type = "network";
              }
              {
                operand = "dest.port";

                data = "5353";
                type = "simple";
              }
              {
                operand = "process.path";

                data = "${lib.getBin pkgs.kdePackages.kdeconnect-kde}/bin/.kdeconnectd-wrapped";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-kdeconnect-224-5353"

        # INTENT: KDEConnect can do IPv4 broadcast
        "0-OPEN-kdeconnect-ipv4_broadcast" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-kdeconnect-ipv4_broadcast";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.ip";

                data = "255.255.255.255";
                type = "simple";
              }
              {
                operand = "process.path";

                data = "${lib.getBin pkgs.kdePackages.kdeconnect-kde}/bin/.kdeconnectd-wrapped";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-kdeconnect-ipv4_broadcast"

        # INTENT: KDEConnect can reach out to the local network
        "0-OPEN-kdeconnect-192_168" = {
          created = "2024-11-27T22:00:00-03:00";
          updated = "2024-11-27T22:00:00-03:00";

          name = "0-OPEN-kdeconnect-192_168";
          enabled = true;
          precedence = true;
          action = "allow";
          duration = "always";
          operator = {
            operand = "list";

            list = [
              {
                operand = "dest.network";

                data = "192.168.0.0/16";
                type = "network";
              }
              {
                operand = "process.path";

                data = "${lib.getBin pkgs.kdePackages.kdeconnect-kde}/bin/.kdeconnectd-wrapped";
                type = "simple";
              }
            ];
            type = "list";
          };
        };  # "0-OPEN-kdeconnect-192_168"

      };  # ..services.opensnitch.rules
    };  # ..services.opensnitch

    displayManager = {
      defaultSession = "plasma";
    };

    desktopManager = {
      # ~/Code/github/Dietr1ch/nixpkgs/nixos/modules/services/desktop-managers/plasma6.nix
      plasma6 = {
        enable = true;
      };
    };
  };  # ..services

  environment = {
    systemPackages = with pkgs; [
      # Qt
      qt6.qtwayland
      kdePackages.kwayland
      kdePackages.qtbase

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
      kdePackages.plasma-browser-integration

      # Theme
      kdePackages.breeze
      # kdePackages.breeze-grub
      kdePackages.breeze-gtk
      kdePackages.breeze-icons
      kdePackages.breeze-plymouth

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

  # https://search.nixos.org/options?channel=unstable&show=qt
  qt = {
    enable = true;
    style = lib.mkDefault "breeze";
    platformTheme = lib.mkDefault "kde6";
  };

  boot = {
    # https://search.nixos.org/options?channel=unstable&query=boot.loader
    loader = {
      # https://search.nixos.org/options?channel=unstable&query=boot.grub
      grub = {
        theme = lib.mkDefault "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
      };
    };
  };
}

