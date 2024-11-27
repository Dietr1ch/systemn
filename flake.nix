{
  description = "System N";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosModules = let
      import = path: path; # let the module system know what we are exporting
    in {
      all = import ./all.nix;

      # System - Things in between the hardware and the user level
      system = import ./system;  # ./system/default.nix

      system-base = import ./system/base;  # ./system/base/default.nix

      system-boot-silent = import ./system/boot/silent.nix;
      system-boot-plymouth = import ./system/boot/plymouth.nix;

      system-security = import ./system/security;
      # Audit
      system-storage = import ./system/storage;  # ./system/storage/default.nix

      system-input-mouse = import ./system/input/mouse.nix;
      system-input-touchpad = import ./system/input/touchpad.nix;
      system-input-keyboard = import ./system/input/keyboard.nix;
      system-input-keyboard-dvorak = import ./system/input/keyboard/dvorak.nix;
      # Networking
      system-networking = import ./system/networking;
      system-networking-connectivity-dns = import ./system/networking/connectivity/dns.nix;
      # system-networking-connectivity-wireguard = import ./system/networking/connectivity/wireguard.nix;
      system-networking-connectivity-zerotier = import ./system/networking/connectivity/zerotier.nix;

      system-hardware-bluetooth = import ./system/hardware/bluetooth;

      desktop = import ./desktop;  # ./desktop/default.nix
      desktop-gaming = import ./desktop/gaming;  # ./desktop/gaming/default.nix
      desktop-shell-graphical = import ./desktop/shell/graphical;  # ./desktop/shell/graphical/default.nix
      desktop-shell-terminal = import ./desktop/shell/terminal;  # ./desktop/shell/terminal/default.nix

      audio = import ./audio;
      # Pipewire
      # Musnix

      # laptop = import ./laptop/;

      server-web = import ./server/web.nix;
      server-nix-serve = import ./server/nix-serve.nix;

      workstation-virtualisation = import ./workstation/virtualisation;  # ./workstation/virtualisation/default.nix
      workstation-database-postgres = import ./workstation/database/postgres.nix;
      #workstation-shares = import ./workstation/shares;

      network = import ./network;
      # OpenSnitch
      # NFS
      # Samba
      # Tools: openssh, wol, wget, sshfs-fuse

      info = import ./info;
      # lsusb
      # lspci
      # lscpu
      # lsgpu
      info-video = import ./info/video;
      # glxinfo
      # vulkan-tools
      info-network = import ./info/network;
      # nmap

      users = import ./users;
      # Default shell
      users-root = import ./users/root;
      # Initial password
      users-dietr1ch = import ./users/dietr1ch;
      # Initial password
    };
  };
}
