{
  description = "System N";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosModules = let
      import = path: path; # let the module system know what we are exporting
    in {
      # Hardware
      # --------
      hardware-bluetooth = import ./hardware/bluetooth.nix;
      hardware-graphics = import ./hardware/graphics.nix;
      hardware-keyboard-ergodox_ez = import ./hardware/keyboard/ergodox_ez.nix;
      hardware-truerng = import ./hardware/truerng.nix;
      hardware-printing = import ./hardware/printing.nix;
      hardware-scanning = import ./hardware/scanning.nix;
      hardware-phone = import ./hardware/laptop;  # ./hardware/phone.nix
      # Laptop
      hardware-laptop = import ./hardware/laptop;  # ./hardware/laptop/default.nix
      hardware-laptop-power = import ./hardware/laptop/power.nix;
      # Workstation
      hardware-workstation = import ./hardware/workstation;  # ./hardware/workstation/default.nix
      hardware-workstation-power = import ./hardware/workstation/power.nix;  # ./hardware/workstation/power.nix

      # System
      # ------
      # Things in between the hardware and the user level
      system = import ./system;  # ./system/default.nix

      system-base = import ./system/base;  # ./system/base/default.nix
      system-base-hardware_information = import ./system/base/hardware_information.nix;

      system-boot-efi = import ./system/boot/efi.nix;
      system-boot-silent = import ./system/boot/silent.nix;
      system-boot-plymouth = import ./system/boot/plymouth.nix;

      system-security = import ./system/security;  # ./system/security/default.nix
      system-security-yubikey = import ./system/security/yubikey.nix;
      # Audit
      system-storage = import ./system/storage;  # ./system/storage/default.nix

      system-input-mouse = import ./system/input/mouse.nix;
      system-input-touchpad = import ./system/input/touchpad.nix;
      system-input-keyboard = import ./system/input/keyboard.nix;
      system-input-keyboard-dvorak = import ./system/input/keyboard/dvorak.nix;
      # Networking
      system-networking = import ./system/networking;  # ./system/networking/default.nix
      system-networking-connectivity = import ./system/networking/connectivity/default.nix;
      system-networking-connectivity-dns = import ./system/networking/connectivity/dns/default.nix;
      # system-networking-connectivity-wireguard = import ./system/networking/connectivity/wireguard.nix;
      system-networking-connectivity-zerotier = import ./system/networking/connectivity/zerotier.nix;
      system-networking-firewall = import ./system/networking/firewall.nix;

      # Desktop
      # -------
      desktop = import ./desktop;  # ./desktop/default.nix
      desktop-gaming = import ./desktop/gaming;  # ./desktop/gaming/default.nix
      desktop-sound = import ./desktop/sound;  # ./desktop/sound.nix
      desktop-shell-graphical = import ./desktop/shell/graphical;  # ./desktop/shell/graphical/default.nix
      desktop-shell-terminal = import ./desktop/shell/terminal;  # ./desktop/shell/terminal/default.nix


      # Workstation
      # -----------
      workstation = import ./workstation;  # ./workstation/default.nix
      workstation-virtualisation = import ./workstation/virtualisation;  # ./workstation/virtualisation/default.nix
      #workstation-shares = import ./workstation/shares;

      # Server
      # ------
      server-database-postgres = import ./server/database/postgres.nix;
      server-web = import ./server/web.nix;
      server-monero = import ./server/monero.nix;
      server-nix_serve = import ./server/nix-serve.nix;
      server-file_sharing-ipfs = import ./server/file_sharing/ipfs.nix;

      # Drafts
      # ------
      network = import ./network;
      # OpenSnitch
      # NFS
      # Samba

      info = import ./info;
      # lsusb
      # lspci
      # lscpu
      # lsgpu
      info-video = import ./info/video;
      # glxinfo
      # vulkan-tools
      info-network = import ./info/network;

      users = import ./users;
      # Default shell
      users-root = import ./users/root;
      # Initial password
      users-dietr1ch = import ./users/dietr1ch;
      # Initial password
    };
  };
}
