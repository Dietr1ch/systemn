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

      system-shell = import ./system/shell.nix;

      system-security = import ./system/security;
      # Audit
      system-storage = import ./system/storage;  # ./system/storage/default.nix
      # system-locale = import ./system/locale.nix;
      system-input-mouse = import ./system/input/mouse.nix;
      system-input-touchpad = import ./system/input/touchpad.nix;
      system-input-keyboard = import ./system/input/keyboard.nix;
      # Networking
      system-networking-connectivity-dns = import ./system/networking/connectivity/dns.nix;
      # system-networking-connectivity-wireguard = import ./system/networking/connectivity/wireguard.nix;
      system-networking-connectivity-zerotier = import ./system/networking/connectivity/zerotier.nix;

      server-web = import ./server/web.nix;
      server-nix-serve = import ./server/nix-serve.nix;

      system-hardware-bluetooth = import ./system/hardware/bluetooth;

      desktop = import ./desktop;
      desktop-login-sddm = import ./desktop/login/sddm;
      desktop-fonts = import ./desktop/fonts;
      desktop-shell-terminal = import ./desktop/shell/terminal;
      # Alacritty
      # tmux
      # Helix
      # Fd, ripgrep, broot
      desktop-shell-kde = import ./desktop/shell/kde;
      # Portal
      # GTK / Qt5 integration
      desktop-shell-hyprland = import ./desktop/shell/hyprland;
      # Portal

      audio = import ./audio;
      # Pipewire
      # Musnix

      gaming = import ./gaming;
      # Steam
      # Create %games
      # Gamemode - Including no sudo for %games

      # laptop = import ./laptop/;

      workstation-database = import ./workstation/database;
      workstation-shares = import ./workstation/shares;
      # Postgres

      network = import ./network;
      # OpenSnitch
      # NFS
      # Samba
      # Tools: openssh, wol, wget, sshfs-fuse

      info = import ./info;
      # neofetch
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
