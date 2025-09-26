{ pkgs, lib, ... }:

# ~/Projects/nixpkgs/nixos/modules/services/desktop-managers/plasma6.nix
{
  programs = {
    # ~/Projects/nixpkgs/nixos/modules/programs/xwayland.nix
    xwayland.enable = lib.mkDefault false; # TODO: Drop xwayland when feasible
    # ~/Projects/nixpkgs/nixos/modules/programs/kdeconnect.nix
    # https://search.nixos.org/options?channel=unstable&query=kdeconnect
    kdeconnect.enable = true;
    # TODO: Consider dropping kde-pim
    # kde-pim.enable = lib.mkForce false;  # Drop KDE PIM (KMail, Kontact, ...)

    gnupg = {
      # https://search.nixos.org/options?channel=unstable&query=programs.gnupg.agent
      agent = {
        pinentryPackage = lib.mkDefault pkgs.pinentry-qt;
      };
    };
  };

  services = {
    xserver.enable = lib.mkForce false;
    orca.enable = lib.mkForce false; # No screenreading, sorry :(

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
        }; # "0-OPEN-kdeconnect-ff02_64-5353"

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
        }; # "0-OPEN-kdeconnect-fe80_64-5353"

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
        }; # "0-OPEN-kdeconnect-224-5353"

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
        }; # "0-OPEN-kdeconnect-ipv4_broadcast"

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
        }; # "0-OPEN-kdeconnect-192_168"

      }; # ..services.opensnitch.rules
    }; # ..services.opensnitch

    displayManager = {
      defaultSession = "plasma";
    };

    displayManager = {
      # ./login-sddm.nix
      sddm = {
        wayland = {
          compositor = "kwin";
        };
      };
    };
    desktopManager = {
      # ~/Projects/nixpkgs/nixos/modules/services/desktop-managers/plasma6.nix
      plasma6 = {
        enable = true;
      };
    };
  }; # ..services

  environment = {
    systemPackages = with pkgs; [
      # Qt
      qt6.qtwayland
      kdePackages.kwayland
      kdePackages.qtbase

      pinentry-qt

      wayland-protocols
      kdePackages.plasma-wayland-protocols
      kdePackages.wayland-protocols
      kdePackages.wayqt

      kdePackages.plasma-pa # NOTE: Enabled through Pulse Audio, hardware.pulseaudio.enable
      kdePackages.plasma-nm # NOTE: Enabled through NetworkManager, networking.networkmanager.(enable)

      kdePackages.polkit-kde-agent-1

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
        xwaylandvideobridge

        elisa # Simple music player aiming to provide a nice experience for its users
        kate # Text editor
        kdepim-runtime # Akonadi agents and resources
        kmahjongg # KMahjongg is a tile matching game for one or two players
        kmines # KMines is the classic Minesweeper game
        konversation # User-friendly and fully-featured IRC client
        kpat # KPatience offers a selection of solitaire card games
        ksudoku # KSudoku is a logic-based symbol placement puzzle
        ktorrent # Powerful BitTorrent client
      ];
    };
  };
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
      ];
    };
  };

  # https://search.nixos.org/options?channel=unstable&show=qt
  qt = {
    enable = true;
    style = lib.mkDefault "breeze";
    platformTheme = lib.mkDefault "kde";
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
