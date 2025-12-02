{ pkgs, ... }:

# https://nixos.wiki/wiki/Virt-manager
{
  programs = {
    virt-manager = {
      enable = true;
    };
  };

  virtualisation = {
    containers = {
      # Enable common container config files in /etc/containers
      enable = true;
    };

    libvirtd = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      virt-manager
    ];
  };
}
