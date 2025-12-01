{
  description = "System N";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosModules =
        let
          import = path: path; # let the module system know what we are exporting
        in
        {
          # Hardware
          # --------
          hardware = import ./hardware; # ./hardware/default.nix
          hardware-bluetooth = import ./hardware/bluetooth.nix;
          hardware-graphics = import ./hardware/graphics/default.nix;
          hardware-graphics-amd = import ./hardware/graphics/amd.nix;
          hardware-keyboard-ergodox_ez = import ./hardware/keyboard/ergodox_ez.nix;
          hardware-memtest = import ./hardware/memtest.nix;
          hardware-phone = import ./hardware/phone.nix;
          hardware-printing = import ./hardware/printing.nix;
          hardware-scanning = import ./hardware/scanning.nix;
          hardware-storage = import ./hardware/storage.nix;
          hardware-truerng = import ./hardware/truerng.nix;
          hardware-usb = import ./hardware/usb.nix;
          # Laptop
          hardware-laptop = import ./hardware/laptop; # ./hardware/laptop/default.nix
          hardware-laptop-power = import ./hardware/laptop/power.nix;
          # Workstation
          hardware-workstation = import ./hardware/workstation; # ./hardware/workstation/default.nix
          hardware-workstation-power = import ./hardware/workstation/power.nix;

          # System
          # ------
          # Things in between the hardware and the user level
          system = import ./system; # ./system/default.nix

          system-base = import ./system/base; # ./system/base/default.nix
          system-base-hardware_information = import ./system/base/hardware_information.nix;
          system-base-watchdog = import ./system/base/watchdog.nix;

          system-boot-efi = import ./system/boot/efi.nix;
          system-boot-silent = import ./system/boot/silent.nix;
          system-boot-plymouth = import ./system/boot/plymouth.nix;

          system-security = import ./system/security; # ./system/security/default.nix
          system-security-yubikey = import ./system/security/yubikey.nix;
          # Audit
          system-storage = import ./system/storage; # ./system/storage/default.nix

          system-input-keyboard-dvorak = import ./system/input/keyboard/dvorak.nix;
          system-input-keyboard-intl = import ./system/input/keyboard/intl.nix;
          system-input-mouse = import ./system/input/mouse.nix;
          system-input-touchpad = import ./system/input/touchpad.nix;
          system-input-racing_wheel = import ./system/input/racing_wheel.nix;
          # Networking
          system-networking = import ./system/networking; # ./system/networking/default.nix
          system-networking-connectivity = import ./system/networking/connectivity/default.nix;
          system-networking-connectivity-dns = import ./system/networking/connectivity/dns/default.nix;
          system-networking-connectivity-wireguard = import ./system/networking/connectivity/wireguard.nix;
          system-networking-connectivity-zerotier = import ./system/networking/connectivity/zerotier.nix;
          system-networking-firewall = import ./system/networking/firewall.nix;

          # Desktop
          # -------
          desktop = import ./desktop; # ./desktop/default.nix
          desktop-gaming = import ./desktop/gaming; # ./desktop/gaming/default.nix
          desktop-gaming-wine = import ./desktop/gaming/wine.nix;
          desktop-shell-graphical = import ./desktop/shell/graphical; # ./desktop/shell/graphical/default.nix
          desktop-shell-graphical-audio = import ./desktop/shell/graphical/audio.nix;
          desktop-shell-graphical-browser = import ./desktop/shell/graphical/browser/default.nix;
          desktop-shell-graphical-browser-chromium = import ./desktop/shell/graphical/browser/chromium.nix;
          desktop-shell-graphical-browser-librewolf = import ./desktop/shell/graphical/browser/librewolf.nix;
          desktop-shell-graphical-browser-misc = import ./desktop/shell/graphical/browser/misc.nix;
          desktop-shell-graphical-cad = import ./desktop/shell/graphical/cad.nix;
          desktop-shell-graphical-hyprland = import ./desktop/shell/graphical/hyprland.nix;
          desktop-shell-graphical-images = import ./desktop/shell/graphical/images.nix;
          desktop-shell-graphical-login = import ./desktop/shell/graphical/login-sddm.nix;
          desktop-shell-graphical-office = import ./desktop/shell/graphical/office.nix;
          desktop-shell-graphical-plasma = import ./desktop/shell/graphical/plasma.nix;
          desktop-shell-graphical-video = import ./desktop/shell/graphical/video.nix;
          desktop-shell-terminal = import ./desktop/shell/terminal; # ./desktop/shell/terminal/default.nix
          desktop-shell-terminal-documents = import ./desktop/shell/terminal/documents.nix;
          desktop-shell-terminal-pay_respects = import ./desktop/shell/terminal/pay-respects.nix;
          desktop-sound = import ./desktop/sound.nix;

          # Workstation
          # -----------
          workstation = import ./workstation; # ./workstation/default.nix
          workstation-virtualisation = import ./workstation/virtualisation; # ./workstation/virtualisation/default.nix
          #workstation-shares = import ./workstation/shares;

          # Server
          # ------
          server-certificates = import ./server/certificates.nix;
          server-database-postgres = import ./server/database/postgres.nix;
          server-file_sharing-ipfs = import ./server/file_sharing/ipfs.nix;
          server-file_sharing-nfs = import ./server/file_sharing/nfs.nix;
          server-file_sharing-samba = import ./server/file_sharing/samba.nix;
          server-grafana = import ./server/grafana.nix;
          server-immich = import ./server/immich.nix;
          server-monero = import ./server/monero.nix;
          server-nix_serve = import ./server/nix-serve.nix;
          server-nix_ssh = import ./server/nix-ssh.nix;
          server-ollama = import ./server/ollama.nix;
          server-prometheus = import ./server/prometheus.nix;
          server-syncthing = import ./server/syncthing.nix;
          server-tor = import ./server/tor.nix;
          server-tor_relay = import ./server/tor_relay.nix;
          server-transmission = import ./server/transmission.nix;
          server-web = import ./server/web.nix;
          server-yggdrasil = import ./server/yggdrasil.nix;
        };
    };
}
