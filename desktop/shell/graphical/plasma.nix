{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
    };

    displayManager = {
      defaultSession = "plasma";
    };

    desktopManager = {
      plasma6.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      plasma-pa
      plasma-nm

      cryptsetup
      plasma-vault

      # Dolphin
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.kio
      kdePackages.kio-fuse
      kdePackages.kio-gdrive
      kdePackages.kio-zeroconf

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
  };

  networking = {
    firewall = {
      # TCP
      allowedTCPPortRanges = [
        # KDE Connect
        { from = 1714; to = 1764; }
      ];

      # UDP
      allowedUDPPortRanges = [
        # KDE Connect
        { from = 1714; to = 1764; }
      ];
    };
  };
}

